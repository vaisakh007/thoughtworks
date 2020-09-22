resource "azurerm_resource_group" "k8s" {
    name     = var.resource_group_name
    location = var.location
}


resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.k8s.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = "${var.prefix}-network"
  resource_group_name  = azurerm_resource_group.k8s.name
  address_prefixes     = ["10.1.0.0/22"]
  depends_on = [azurerm_virtual_network.example]
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name
    dns_prefix          = var.dns_prefix

      identity {
      type = "SystemAssigned"
    }


    default_node_pool {
        name            = "agentpool"
        node_count      = var.agent_count
        vm_size         = "Standard_D2_v2"
        vnet_subnet_id = azurerm_subnet.internal.id
    }

    network_profile {
    load_balancer_sku = "Standard"
    network_plugin = "azure"
    }

    tags = {
        Environment = "Development"
    }
}
