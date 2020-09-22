variable "prefix" {
  description = "A prefix used for all resources in this example"
  default= "aks"
}


variable "agent_count" {
    default = 1
}



variable "dns_prefix" {
    default = "k8sthoughtworksassigment"
}

variable cluster_name {
    default = "k8s"
}

variable resource_group_name {
    default = "azure-k8s"
}

variable location {
    default = "Central US"
}
