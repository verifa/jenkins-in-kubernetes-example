resource "azurerm_kubernetes_cluster" "jenkinsk8sexample" {
  name                = "aks-jenkinsk8sexample"
  location            = azurerm_resource_group.jenkinsk8sexample.location
  resource_group_name = azurerm_resource_group.jenkinsk8sexample.name
  dns_prefix          = "aks-jenkinsk8sexample"

  default_node_pool {
    name                  = "default"
    node_count            = 1
    vm_size               = "Standard_B2s"
    enable_auto_scaling   = true
    min_count             = 1
    max_count             = 4
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}
