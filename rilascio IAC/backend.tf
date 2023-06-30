# Creazione del backend per salvare il file .tfstate
terraform {
  backend "azurerm" {
    storage_account_name = "iannellitfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "${env.JENKINS_SECRET_AzureStorageAccessKey}"
  }
}