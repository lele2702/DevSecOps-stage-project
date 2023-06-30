# Crea la macchina virtuale
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "centos-iac-vm"
  location              = "westeurope"
  resource_group_name   = data.azurerm_resource_group.lab_rg.name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = "Standard_F2"
  computer_name  = "CentOsVM"
    admin_username = "azureuser"
    admin_password = "Password1234!"
    disable_password_authentication = false
   custom_data = filebase64("customdata.sh")
  
  tags = {
    environment = "production"
    project     = "iac-iannelli"
    owner       = "gioele-iannelli"
  }

  os_disk {
    name              = "my-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9"
    version   = "latest"
  }
}