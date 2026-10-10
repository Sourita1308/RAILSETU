// MySQL Server configuration module
@description('Location for MySQL Server')
param location string

@description('MySQL Server name')
param mysqlServerName string

@description('MySQL SKU tier (Burstable, GeneralPurpose, MemoryOptimized)')
param mysqlSkuName string = 'Standard_B2s'

@description('MySQL Server version')
param mysqlVersion string = '8.0.21'

@description('Storage size in GB')
param mysqlStorageGB int = 20

@description('MySQL Administrator username')
param mysqlAdminUsername string = 'railway_admin'

@secure()
@description('MySQL Administrator password')
param mysqlAdminPassword string

@description('App Service name for firewall rule')
param appServiceName string

param tags object = {}

// MySQL Flexible Server
resource mysqlServer 'Microsoft.DBforMySQL/flexibleServers@2021-05-01' = {
  name: mysqlServerName
  location: location
  tags: tags
  sku: {
    name: mysqlSkuName
    tier: 'Burstable'
  }
  properties: {
    administratorLogin: mysqlAdminUsername
    administratorLoginPassword: mysqlAdminPassword
    version: mysqlVersion
    storage: {
      storageSizeGB: mysqlStorageGB
      iops: 360
      autoGrow: 'Enabled'
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    // No VNet integration configured. Remove network settings or supply a valid delegated subnet resource id if using VNet.
    highAvailability: {
      mode: 'Disabled'
    }
    maintenanceWindow: {
      customWindow: 'Disabled'
      startHour: 0
      startMinute: 0
      dayOfWeek: 0
    }
  }
}

// Database
resource railwayDatabase 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
  parent: mysqlServer
  name: 'railwaydb'
  properties: {
    charset: 'utf8mb4'
    collation: 'utf8mb4_unicode_ci'
  }
}

// Allow All Azure IPs (for App Service connectivity)
resource allowAzureServicesFirewallRule 'Microsoft.DBforMySQL/flexibleServers/firewallRules@2021-05-01' = {
  parent: mysqlServer
  name: 'AllowAllAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

@description('MySQL Server fully qualified domain name')
output fqdn string = mysqlServer.properties.fullyQualifiedDomainName

@description('MySQL Server resource ID')
output resourceId string = mysqlServer.id

@description('MySQL Server name')
output serverName string = mysqlServer.name
