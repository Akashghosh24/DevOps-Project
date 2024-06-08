#!/bin/bash
#We are using Ubuntu 22.04 as its compatible with our task
# This can be run at once to deploy the machine and it's related resources.
# Variables
resourceGroup="rg-akash"
location="Central India"
vmName="azdoagentvm"
vmSize="Standard_B4ms"
image="Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest"
adminUsername="adminuser"
adminPassword="Admin@123456"

ServicePrincipal="<Client ID>"
Secret="<Secret>"
TenantID="f3eecbb4-2c11-4444-9d12-620a608677ef"


az login --service-principal -u $ServicePrincipal -p $Secret --tenant $TenantID

# Create Resource Group
#az group create --name $resourceGroup --location "$location"

# Create Virtual Network and Subnet
az network vnet create --resource-group $resourceGroup --name AzdoagentVnet --subnet-name AzDoagentSubnet

# Create Public IP Address
az network public-ip create --resource-group $resourceGroup --name AzdoagentIP --allocation-method Static --sku Standard

# Create Network Security Group
az network nsg create --resource-group $resourceGroup --name AzdoagentNetworkSecurityGroup

# Create Network Security Group Rule to Allow SSH
az network nsg rule create --resource-group $resourceGroup --nsg-name AzdoagentNetworkSecurityGroup --name AllowSSH --protocol Tcp --direction Inbound --priority 1000 --source-address-prefixes "*" --source-port-ranges "*" --destination-address-prefixes "*" --destination-port-ranges 22 --access Allow

# Create Network Interface Card (NIC)
az network nic create --resource-group $resourceGroup --name AzdoagentNic --vnet-name AzdoagentVnet --subnet AzDoagentSubnet --network-security-group AzdoagentNetworkSecurityGroup --public-ip-address AzdoagentIP

# Create the VM
az vm create \
  --resource-group $resourceGroup \
  --name $vmName \
  --size $vmSize \
  --image $image \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --nics AzdoagentNic \
  --public-ip-sku Standard

# Open Port 22 to allow SSH traffic to host
az vm open-port --port 22 --resource-group $resourceGroup --name $vmName

# Output the public IP address of the VM
publicIp=$(az vm show -d -g $resourceGroup -n $vmName --query publicIps -o tsv)
echo "The VM is created. You can access it via SSH using the following command:"
echo "ssh $adminUsername@$publicIp"
