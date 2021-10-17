terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.10.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "random" {
}

resource "random_id" "server" {
  byte_length = 4
}


provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "Duncan" {
  name       = "Terraform Shoor"
  public_key = file("<public_key_path>")
}

resource "digitalocean_droplet" "web" {
  image    = var.image
  name     = "shoor-webserver-${random_id.server.hex}"
  region   = "sgp1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}
