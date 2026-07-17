terraform {
  required_version = ">= 1.12.4"

  backend "local" {}

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }
  }
}

provider "github" {
  owner = var.owner
}
