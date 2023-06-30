data "azurerm_resource_group" "lab_rg" {
  name = "BU-MT"
}

data "azurerm_virtual_network" "lab_vnet" {
  name                = "BU-MT-vnet-TF"
  resource_group_name = data.azurerm_resource_group.lab_rg.name
}