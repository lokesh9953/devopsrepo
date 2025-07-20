module "resource_group" {
  source                  = "../child/azurerm_resource_group"
  resource_group_name     = "rg-todoapp"
  resource_group_location = "centralIndia"
}

module "resource_group" {
  source                  = "../child/azurerm_resource_group"
  resource_group_name     = "rg-todoapp2"
  resource_group_location = "centralIndia"
}
  

module "resource_group" {
  source                  = "../child/azurerm_resource_group"
  resource_group_name     = "rg-todoapp3"
  resource_group_location = "centralIndia"
}
 
module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../child/azurerm_virtual_network"

  virtual_network_name     = "vnet-todoapp"
  virtual_network_location = "centralindia"
  resource_group_name      = "rg-todoapp"
  address_space            = ["10.0.0.0/16"]
}

module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../child/azurerm_subnet"

  resource_group_name  = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  subnet          = "frontend-subnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "public_ip_frontend" {
  depends_on          = [module.resource_group]
  source              = "../child/azurerm_public_ip"
  pip_name      = "pip-todoapp-frontend"
  resource_group_name = "rg-todoapp"
  resource_group_location = "centralindia"
}

module "frontend_vm" {
  depends_on = [module.frontend_subnet, module.public_ip_frontend]
  source     = "../child/azurerm_virtual_machine"

  resource_group_name  = "rg-todoapp"
  location             = "centralindia"
  vm_name              = "vm-frontend2"
  vm_size              = "Standard_B1s"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "nic-vm-frontend2"
  frontend_ip_name     = "pip-todoapp-frontend"
  vnet_name            = "vnet-todoapp"
  frontend_subnet_name = "frontend-subnet"
}

