// Parameters file for Railway Management Azure deployment
using 'main.bicep'

param environment = 'prod'
param appName = 'railway'
param location = 'centralindia'
param appServiceSkuName = 'S1'
param appServiceSkuTier = 'Standard'
param appServiceCapacity = 1
param mysqlSkuName = 'Standard_B2s'
param mysqlSkuTier = 'Burstable'
param mysqlVersion = '8.0.21'
param mysqlStorageGB = 20
param mysqlAdminUsername = 'railway_admin'
// ⚠️ UPDATE THIS WITH A STRONG PASSWORD: Min 8 chars, must include uppercase, lowercase, numbers, special chars
param mysqlAdminPassword = 'Sourita@rail6'
param enablePublicAccess = false
