@echo off
REM Azure deployment script for Railway Management Application (Windows)
REM This script deploys the application infrastructure to Azure

setlocal enabledelayedexpansion

REM Configuration
set SUBSCRIPTION_ID=%AZURE_SUBSCRIPTION_ID%
set RESOURCE_GROUP_NAME=rg-railway-mgmt
set LOCATION=centralindia
for /f "tokens=* usebackq" %%A in (`powershell Get-Date -Format yyyyMMddHHmmss`) do set DEPLOYMENT_TIME=%%A
set DEPLOYMENT_NAME=railway-deployment-%DEPLOYMENT_TIME%

echo.
echo ============================================
echo Railway Management - Azure Deployment
echo ============================================
echo.

REM Step 1: Check if Azure CLI is installed
echo [STEP 1] Checking Azure CLI installation...
az --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Azure CLI is not installed.
    echo Please install from: https://docs.microsoft.com/cli/azure/install-azure-cli
    exit /b 1
)
echo [OK] Azure CLI found

REM Step 2: Check login status
echo.
echo [STEP 2] Checking Azure CLI login status...
az account show >nul 2>&1
if errorlevel 1 (
    echo [INFO] Please log in to Azure...
    call az login
) else (
    echo [OK] Already logged in
)

REM Step 3: Show current subscription
echo.
echo [STEP 3] Current Azure subscription:
for /f "usebackq" %%i in (`az account show --query id -o tsv`) do set CURRENT_SUBSCRIPTION=%%i
echo Current Subscription ID: %CURRENT_SUBSCRIPTION%

REM Step 4: Create resource group
echo.
echo [STEP 4] Creating resource group: %RESOURCE_GROUP_NAME%...
call az group create ^
    --name %RESOURCE_GROUP_NAME% ^
    --location %LOCATION%

REM Step 5: Validate Bicep
echo.
echo [STEP 5] Validating Bicep template...
call az bicep build --file ./infra/main.bicep
if errorlevel 1 (
    echo [ERROR] Bicep validation failed
    exit /b 1
)
echo [OK] Bicep template valid

REM Step 6: Confirm before deployment
echo.
echo [STEP 6] Pre-deployment checks:
echo WARNING: Update the MySQL admin password in infra/parameters.bicepparam BEFORE deploying!
echo Current password setting: Change-Me@123 (YOU MUST UPDATE THIS)
echo.
set /p PASSWORD_CONFIRMED="Have you updated the MySQL password? (yes/no): "
if /i not "%PASSWORD_CONFIRMED%"=="yes" (
    echo [ERROR] Please update the password in infra/parameters.bicepparam and try again.
    exit /b 1
)

REM Step 7: Deploy infrastructure
echo.
echo [STEP 7] Deploying infrastructure using Bicep...
echo This may take 10-15 minutes...
echo.
call az deployment group create ^
    --name %DEPLOYMENT_NAME% ^
    --resource-group %RESOURCE_GROUP_NAME% ^
    --template-file ./infra/main.bicep ^
    --parameters ./infra/parameters.bicepparam

if errorlevel 1 (
    echo [ERROR] Deployment failed
    exit /b 1
)

REM Step 8: Get outputs
echo.
echo [STEP 8] Retrieving deployment outputs...
call az deployment group show ^
    --name %DEPLOYMENT_NAME% ^
    --resource-group %RESOURCE_GROUP_NAME% ^
    --query properties.outputs > .azure\deployment-outputs.json

echo [OK] Outputs saved to .azure\deployment-outputs.json

REM Step 9: Display summary
echo.
echo ============================================
echo DEPLOYMENT COMPLETED SUCCESSFULLY!
echo ============================================
echo.
echo Resource Group: %RESOURCE_GROUP_NAME%
echo Location: %LOCATION%
echo Deployment Name: %DEPLOYMENT_NAME%
echo.
echo Next Steps:
echo 1. Build the application: mvn clean package
echo 2. Update database connection in src/main/java/db/DBConnection.java
echo 3. Deploy WAR file to App Service
echo.
echo For more details, check: .azure\deployment-outputs.json
echo.
pause
