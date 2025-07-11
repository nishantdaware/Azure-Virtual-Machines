// Windows Virtual Machine

resource "azurerm_network_interface" "vm-nic" {
  name                = "${var.prefix}-vm-nic"
  location            = var.location
  resource_group_name = var.virtual_machine_rg

  ip_configuration {
    name                          = "vm-nic-ip-configuration"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "windows-vm" {
  name                  = "${var.prefix}-windows-vm"
  location              = var.location
  resource_group_name   = var.virtual_machine_rg
  network_interface_ids = [azurerm_network_interface.vm-nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

// Linux Virtual Machine

resource "azurerm_network_interface" "linux-vm-nic" {
  name                = "${var.prefix}-linux-vm-nic"
  location            = var.location
  resource_group_name = var.virtual_machine_rg

  ip_configuration {
    name                          = "linux-vm-nic-ip-configuration"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = "${var.prefix}-linux-vm"
  resource_group_name = var.virtual_machine_rg
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linux-vm-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/Users/Nishant/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
