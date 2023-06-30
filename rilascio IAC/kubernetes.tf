# Creazione del cluster AKS
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster2"
  location            = "westeurope"
  resource_group_name = data.azurerm_resource_group.lab_rg.name
  dns_prefix          = "myaks"
  azure_policy_enabled = true
  http_application_routing_enabled = true

  network_profile {
      network_plugin = "azure"
      network_policy = "azure"
  }

  default_node_pool {
    name            = "akspool"
    node_count      = 1
    vm_size         = "Standard_D4s_v3"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }


  tags = {
    environment = "production"
    project     = "iac-iannelli"
    owner       = "gioele-iannelli"
  }
}
