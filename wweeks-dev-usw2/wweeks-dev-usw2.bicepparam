using './wweeks-dev-usw2.bicep'

var ProjectName = 'wweeks'
var Environment = 'dev'
var CAFLocation = 'usw2'
var InstanceNumber = '001' 
var subscriptionId = 'e0901d2b-0413-4132-a23e-b2890ed4e2e7'
var resourceGroupName = 'rg-mgmt'

var keyVaultName = 'kv-${ProjectName}-${Environment}-${CAFLocation}-${InstanceNumber}'
var userAssignedName = 'umi-${ProjectName}-${Environment}-${CAFLocation}-${InstanceNumber}'
param location = 'westus2'
param storageSKU = 'Standard_ZRS'
param allowedIP = '192.16.100.101'
param storageName = 'st${ProjectName}${Environment}${CAFLocation}${InstanceNumber}'
param keyName = 'key-${ProjectName}-${Environment}-${CAFLocation}-${InstanceNumber}'
param userAssignedId = '/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${userAssignedName}'
param keyVaultid = '/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.KeyVault/vaults/${keyVaultName}'


