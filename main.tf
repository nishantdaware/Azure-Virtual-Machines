resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.virtual_machine_rg
}

resource "azurerm_subnet" "snet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = var.virtual_machine_rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
