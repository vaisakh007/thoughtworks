provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you are using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name   = "terraformrg"
        storage_account_name  = "thoughtworksterraformrg"
        container_name        = "tstate"
        key                   = "terraform.tfstate"
    }
}