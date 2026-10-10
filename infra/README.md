# Infrastructure as Code - Railway Management Azure Deployment

## 📋 Overview

This directory contains Bicep Infrastructure as Code (IaC) templates to deploy the Railway Management application to Azure.

## 📁 Files

- **main.bicep** - Main deployment template that orchestrates all resources
- **mysql.bicep** - MySQL Flexible Server configuration module
- **parameters.bicepparam** - Parameter file with deployment configuration values
- **deploy.sh** - Bash script for Linux/macOS deployment
- **deploy.bat** - Batch script for Windows deployment

## 🏗️ Architecture

The deployment creates the following Azure resources:

```
┌─────────────────────────────────────────┐
│ Resource Group: rg-railway-mgmt         │
├─────────────────────────────────────────┤
│                                         │
│ ┌─ Compute Services                 │  │
│ │ - App Service (Java Runtime)      │  │
│ │ - App Service Plan (S1 Standard)  │  │
│ │                                   │  │
│ │ ┌─ Data Services                 │  │
│ │ │ - MySQL Flexible Server        │  │
│ │ │ - Database: railwaydb          │  │
│ │                                   │  │
│ │ ┌─ Security Services             │  │
│ │ │ - Key Vault                    │  │
│ │ │ - Managed Identity             │  │
│ │                                   │  │
│ │ ┌─ Monitoring Services           │  │
│ │ │ - Application Insights         │  │
│ │ │ - Log Analytics Workspace      │  │
│ │                                   │  │
│ └───────────────────────────────── ┘  │
│                                         │
└─────────────────────────────────────────┘
```

## 🔧 Prerequisites

### Required Software
- **Azure CLI** (v2.40+) - [Install](https://docs.microsoft.com/cli/azure/install-azure-cli)
- **Bicep CLI** (v0.13+) - Included with Azure CLI
- **Maven** (v3.6+) - For building the application
- **Git** - For version control

### Required Access
- Azure subscription with enough quota for:
  - 1x App Service (S1)
  - 1x MySQL Flexible Server (Standard B2s)
  - 1x Key Vault
  - 1x Application Insights
  - 1x Log Analytics

## 📝 Configuration

### 1. Update Parameters

Edit `parameters.bicepparam` to customize your deployment:

```bicep
param environment = 'prod'                  # dev, staging, prod
param appName = 'railway'                   # Application name prefix
param location = 'centralindia'             # Azure region
param appServiceSkuName = 'S1'              # App Service SKU
param mysqlStorageGB = 20                   # Initial storage size
param mysqlAdminUsername = 'railway_admin'  # MySQL admin user
param mysqlAdminPassword = 'ChangeMe@123'   # ⚠️ CHANGE THIS!
```

### 2. Set MySQL Password

**IMPORTANT:** Before deploying, update the MySQL admin password in `parameters.bicepparam`:

```bicep
// ❌ CURRENT (WEAK)
param mysqlAdminPassword = 'ChangeMe@123'

// ✅ RECOMMENDED (STRONG)
param mysqlAdminPassword = 'Y0urStr0ng!Password#2024'
```

**Password Requirements:**
- Minimum 8 characters
- Must include: uppercase, lowercase, numbers, special characters
- No common words or usernames
- Examples: `Azure@Railway2024!`, `RailwayMS#2024Safe`

## 🚀 Deployment Steps

### Option A: Windows Users (Use this command)

```bash
cd d:\RailwayManagement
infra\deploy.bat
```

### Option B: Linux/macOS Users

```bash
cd d:/RailwayManagement
chmod +x infra/deploy.sh
./infra/deploy.sh
```

### Manual Deployment (Step-by-step)

```bash
# 1. Login to Azure
az login

# 2. Set subscription (if you have multiple)
az account set --subscription "YOUR_SUBSCRIPTION_ID"

# 3. Create resource group
az group create --name rg-railway-mgmt --location centralindia

# 4. Validate template
az bicep build --file ./infra/main.bicep

# 5. Deploy infrastructure
az deployment group create \
  --name railway-deployment \
  --resource-group rg-railway-mgmt \
  --template-file ./infra/main.bicep \
  --parameters ./infra/parameters.bicepparam \
  --parameters mysqlAdminPassword="YourStrongPassword@123"
```

## ⏱️ Deployment Duration

Expected time for full deployment:
- Azure CLI login: 2-3 minutes
- Infrastructure provisioning: 10-15 minutes
- **Total: ~15-20 minutes**

## 📊 Deployment Outputs

After successful deployment, you'll receive:

```json
{
  "appServiceUrl": "https://railway-app-xxxxx.azurewebsites.net",
  "appServiceName": "railway-app-xxxxx",
  "mysqlServerName": "railway-mysql-xxxxx",
  "mysqlServerUrl": "railway-mysql-xxxxx.mysql.database.azure.com",
  "keyVaultUrl": "https://railway-kv-xxxxx.vault.azure.net/",
  "appInsightsInstrumentationKey": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

These values will be saved to `.azure/deployment-outputs.json`

## 🔐 Security Features

✅ **Implemented Security Best Practices:**

- **Managed Identity**: App Service uses User-Assigned Managed Identity (no credentials in code)
- **Key Vault**: Database credentials stored securely, not in App Service configuration
- **HTTPS Only**: App Service enforces HTTPS for all traffic
- **TLS 1.2+**: Minimum TLS version enforced
- **Firewall Rules**: MySQL allows only Azure IPs
- **Encryption**: Connection strings encrypted in transit
- **Backup**: MySQL automatic backups enabled (7-day retention)
- **Monitoring**: All logs centralized in Log Analytics

## 📊 Cost Estimation

Approximate monthly costs (Central India region):

| Resource | SKU | Approx Cost/Month |
|----------|-----|------------------|
| App Service | S1 Standard | $70-80 |
| MySQL Server | Standard B2s | $80-90 |
| Log Analytics | 1GB/day | $30-50 |
| Application Insights | Basic | Free (with Log Analytics) |
| Key Vault | Standard | $0.50 |
| **Total** | | **$180-220** |

*Note: Costs vary based on usage and region. Use Azure Pricing Calculator for exact estimates.*

## 🔧 Troubleshooting

### Issue: "Bicep file not found"
```bash
# Solution: Make sure you're in the project root directory
cd d:\RailwayManagement
# Then run the script
```

### Issue: "Authentication required"
```bash
# Solution: Login to Azure
az login
# A browser window will open for authentication
```

### Issue: "Insufficient quota"
```bash
# Solution: Check available quota in your subscription
az vm list-usage --location centralindia -o table
# Or use the Tool: appmod-get-available-region-sku
```

### Issue: "MySQL connection fails"
```bash
# Solution: Verify MySQL firewall rules
az mysql flexible-server firewall-rule list \
  --resource-group rg-railway-mgmt \
  --server-name railway-mysql-xxxxx
```

## 📝 Next Steps

After successful deployment:

1. **Build the Application**
   ```bash
   cd d:\RailwayManagement
   mvn clean package
   ```

2. **Update Database Connection**
   - Edit `src/main/java/db/DBConnection.java`
   - Update connection URL from local to Azure:
     ```java
     private static final String URL = "jdbc:mysql://railway-mysql-xxxxx.mysql.database.azure.com:3306/railwaydb?useSSL=true&requireSSL=true";
     private static final String USER = "railway_admin@railway-mysql-xxxxx";
     private static final String PASSWORD = "YourStrongPassword@123";
     ```

3. **Deploy WAR to App Service**
   ```bash
   az webapp deployment source config-zip \
     --resource-group rg-railway-mgmt \
     --name railway-app-xxxxx \
     --src target/RailwayManagement.war
   ```

4. **Verify Deployment**
   - Access: https://railway-app-xxxxx.azurewebsites.net
   - Check logs: `.azure/deployment-outputs.json`

## 📞 Support

For issues with:
- **Azure CLI**: https://docs.microsoft.com/cli/azure/
- **Bicep**: https://docs.microsoft.com/azure/azure-resource-manager/bicep/
- **MySQL on Azure**: https://docs.microsoft.com/azure/mysql/
- **App Service**: https://docs.microsoft.com/azure/app-service/

## 📄 Additional Resources

- [Bicep Documentation](https://docs.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure CLI Reference](https://docs.microsoft.com/cli/azure/reference-index)
- [MySQL Flexible Server Best Practices](https://docs.microsoft.com/azure/mysql/flexible-server/best-practices)
- [App Service Security Best Practices](https://docs.microsoft.com/azure/app-service/security-recommendations)

---

**Last Updated**: 2024
**Bicep Version**: 0.13+
**Azure CLI Version**: 2.40+
