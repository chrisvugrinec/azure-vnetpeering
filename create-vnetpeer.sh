#!/bin/bash

az network vnet list -o table


echo "RG VNET1:"
read rgvnet1
echo "NAME VNET1:"
read namevnet1

echo "RG VNET2:"
read rgvnet2
echo "NAME VNET2:"
read namevnet2

# Get the id for VNet1.
vnet1=$(az network vnet show \
  --resource-group $rgvnet1 \
  --name $namevnet1 \
  --query id --out tsv)

# Get the id for VNet2.
vnet2=$(az network vnet show \
  --resource-group $rgvnet2 \
  --name $namevnet2 \
  --query id --out tsv)

# Peer VNet1 to VNet2.
az network vnet peering create \
  --name vnet1TOvnet2PEER \
  --resource-group $rgvnet1 \
  --vnet-name $namevnet1 \
  --remote-vnet-id $vnet2 \
  --allow-vnet-access

# Peer VNet2 to VNet1.
az network vnet peering create \
  --name vnet2TOvnet1PEER \
  --resource-group $rgvnet2 \
  --vnet-name $namevnet2 \
  --remote-vnet-id $vnet1 \
  --allow-vnet-access
