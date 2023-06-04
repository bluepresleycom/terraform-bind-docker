terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
    dns = {
      source  = "hashicorp/dns"
    }
  }
}

provider "docker" {
  host    = "unix:///var/run/docker.sock"
}

resource "docker_network" "dns_network" {
  name            = "dns_network"
  check_duplicate = "true"
}
resource "docker_network" "dns_network_network_2" {
  name            = "dns_network_2"
  check_duplicate = "true"
}

resource "docker_image" "image" {
  name         = "gliderlabs/alpine:latest"
  keep_locally = true
}

resource "docker_container" "webapp1" {
  name         = "webapp1"
  image        = "${docker_image.image.name}"
 networks_advanced {
    name    = docker_network.dns_network.name
    aliases = ["dns_server"]
  }
}

output "network_data" {
  value = "${docker_container.container.network_data}"
}
// foreach will come 
// https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each
output "ip_addresses" {
  value = "${list(
    lookup(docker_container.container.network_data[0], "ip_address"),
    lookup(docker_container.container.network_data[1], "ip_address")
  )}"
}
