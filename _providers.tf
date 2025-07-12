// Providers block can be copied from terraform registry

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.36.0"
    }
  }
}

provider "azurerm" {

  // The features {} block is mandatory in the azurerm provider, even if it's empty. 
  // Omitting it will cause an error like: The provider configuration is invalid
  
  features {} 

  resource_provider_registrations = "none"
  subscription_id = "0cfe2870-d256-4119-b0a3-16293ac11bdc" // This is temporary subscription id
}
