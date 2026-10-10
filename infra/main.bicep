// Main Bicep template for Railway Management Application deployment to Azure
targetScope = 'resourceGroup'

@description('Environment name (dev, staging, prod)')
param environment string = 'prod'

@description('Application name')
param appName string = 'railway'

@description('Azure region for deployment')
param location string = 'centralindia'

@description('Resource group name')
param resourceGroupName string = resourceGroup().name

// App Service configuration
param appServiceSkuName string = 'S1'
param appServiceSkuTier string = 'Standard'
param appServiceCapacity int = 1

// MySQL Database configuration
param mysqlSkuName string = 'Standard_B2s'
param mysqlSkuTier string = 'Burstable'
param mysqlVersion string = '8.0.21'
param mysqlStorageGB int = 20
param mysqlAdminUsername string = 'railway_admin'

@secure()
param mysqlAdminPassword string

// Networking
param enablePublicAccess bool = false

// Tags
var commonTags = {
  environment: environment
  project: appName
  managedBy: 'Bicep'
}

var appServiceName = '${appName}-app-${uniqueString(resourceGroup().id)}'
var mysqlServerName = '${appName}-mysql-${uniqueString(resourceGroup().id)}'
var keyVaultName = '${appName}-kv-${uniqueString(resourceGroup().id)}'
var appInsightsName = '${appName}-ai-${uniqueString(resourceGroup().id)}'
var logAnalyticsName = '${appName}-la-${uniqueString(resourceGroup().id)}'
var managedIdentityName = '${appName}-mi-${uniqueString(resourceGroup().id)}'

// Log Analytics Workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: logAnalyticsName
  location: location
  tags: commonTags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

// Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  tags: commonTags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 30
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

// User-Assigned Managed Identity
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
  tags: commonTags
}

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  tags: commonTags
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: false
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: managedIdentity.properties.principalId
        permissions: {
          keys: [
            'get'
            'list'
          ]
          secrets: [
            'get'
            'list'
          ]
          certificates: [
            'get'
            'list'
          ]
        }
      }
    ]
  }
}

// Store MySQL connection string in Key Vault
resource mysqlConnectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: 'mysql-connection-string'
  properties: {
    value: 'Server=tcp:${mysqlServerName}.mysql.database.azure.com,3306;Initial Catalog=railwaydb;Persist Security Info=False;User Id=${mysqlAdminUsername}@${mysqlServerName};Password=${mysqlAdminPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
  }
}

// MySQL Server
module mysqlServer 'mysql.bicep' = {
  name: 'mysqlServerDeployment'
  params: {
    location: location
    mysqlServerName: mysqlServerName
    mysqlSkuName: mysqlSkuName
    mysqlVersion: mysqlVersion
    mysqlStorageGB: mysqlStorageGB
    mysqlAdminUsername: mysqlAdminUsername
    mysqlAdminPassword: mysqlAdminPassword
    appServiceName: appServiceName
    tags: commonTags
  }
}

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appName}-plan'
  location: location
  tags: commonTags
  sku: {
    name: appServiceSkuName
    tier: appServiceSkuTier
    capacity: appServiceCapacity
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  tags: commonTags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'JAVA|17-java17'
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'recommended'
        }
        {
          name: 'DATABASE_HOST'
          value: '${mysqlServerName}.mysql.database.azure.com'
        }
        {
          name: 'DATABASE_PORT'
          value: '3306'
        }
        {
          name: 'DATABASE_NAME'
          value: 'railwaydb'
        }
        {
          name: 'DATABASE_USER'
          value: '${mysqlAdminUsername}@${mysqlServerName}'
        }
        {
          name: 'KEY_VAULT_URL'
          value: keyVault.properties.vaultUri
        }
        {
          name: 'MANAGED_IDENTITY_CLIENT_ID'
          value: managedIdentity.properties.clientId
        }
        {
          name: 'JAVA_OPTS'
          value: '-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8'
        }
      ]
      connectionStrings: [
        {
          name: 'DefaultConnection'
          connectionString: 'Server=tcp:${mysqlServerName}.mysql.database.azure.com,3306;Initial Catalog=railwaydb;Persist Security Info=False;User Id=${mysqlAdminUsername}@${mysqlServerName};Password=${mysqlAdminPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
          type: 'MySql'
        }
      ]
      minTlsVersion: '1.2'
      http20Enabled: true
      numberOfWorkers: 1
      defaultDocuments: []
      handlerMappings: []
      managedPipelineMode: 'Integrated'
      virtualApplications: [
        {
          virtualPath: '/'
          physicalPath: 'site\\wwwroot'
          preloadEnabled: true
        }
      ]
    }
  }
}

// Configure Application Insights for App Service
resource appServiceAppInsights 'Microsoft.Web/sites/config@2021-02-01' = {
  parent: appService
  name: 'web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'index.htm'
      'index.html'
    ]
  }
}

// Diagnostic settings to stream logs to Log Analytics
resource appServiceDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${appServiceName}-diagnostics'
  scope: appService
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'AppServiceHTTPLogs'
        enabled: true
      }
      {
        category: 'AppServiceConsoleLogs'
        enabled: true
      }
      {
        category: 'AppServiceAppLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

@description('Output values for deployed resources')
output appServiceUrl string = 'https://${appService.properties.defaultHostName}'
output appServiceName string = appService.name
output mysqlServerName string = mysqlServerName
output mysqlServerUrl string = '${mysqlServerName}.mysql.database.azure.com'
output keyVaultUrl string = keyVault.properties.vaultUri
output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
output managedIdentityClientId string = managedIdentity.properties.clientId
output managedIdentityPrincipalId string = managedIdentity.properties.principalId
