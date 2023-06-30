# Creazione dell'account di archiviazione per il .tfstate
resource "azurerm_storage_account" "tfstate" {
  name                     = "iannellitfstate"
  resource_group_name      = "BU-MT"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "production"
    project     = "iac-iannelli"
    owner       = "gioele-iannelli"
  }
}

# Creazione del contenitore di archiviazione per il .tfstate
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}