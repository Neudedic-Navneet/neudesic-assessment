terraform {
  required_providers {
    azurerm ={
        source = "hashicorp/azurerm"
        version = "3.10.0"
    }
  }
}

provider "azurerm" {
  features{

  }
}

module "resourceGroup" {
    source = "./resource_group"
    basename = "navneet-ass"
    location = "JapanEast"
}

module "vnet" {
  source = "./vnet"
  vnet_name = "vnet"
  resource_group_name = module.resourceGroup.rg_name_out
  location = "JapanEast"
  depends_on = [module.resourceGroup]
}

module "subnet" {
  source = "./subnet"
  subnet = "subnet1"
  vnet_name = module.vnet.vnet_out
  resource_group_name = module.resourceGroup.rg_name_out
  location = "JapanEast"
  depends_on = [
      module.vnet
    ]
}

module "publicIP" {
  source = "./public_ip"
  public_ip = "publicIP"
  resource_group_name = module.resourceGroup.rg_name_out
  location = "JapanEast"
}

module "network_interface" {
  source = "./nic"
  nic_name = "nic01"
  subnetID = module.subnet.subnetId_out
  publicipId_out = module.publicIP.publicipId_out
  resource_group_name = module.resourceGroup.rg_name_out
  location = "JapanEast"
}

module "load_balancer" {
  source = "./load_balancer"
  load_balancer_name = "lbit"
  virtual_network_id = module.vnet.vnet_id
  vmss_name = "vmss"
  nic_name = module.network_interface.nic_name
  subnetID = module.subnet.subnetId_out
  publicipId_out = module.publicIP.publicipId_out
  resource_group_name = module.resourceGroup.rg_name_out
  location = "JapanEast"
}