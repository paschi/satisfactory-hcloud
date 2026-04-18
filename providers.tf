terraform {
  required_providers {
    hcloud = {
      source  = "opentofu/hcloud"
      version = "~> 1.60.1"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}
