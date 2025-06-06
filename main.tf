terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# build the docker image
resource "docker_image" "terraform-app-img" {
  name = "terraform-app-img"
  build {
    context    = "${path.module}/sample-app"
    dockerfile = "${path.module}/sample-app/Dockerfile"
  }
}

# run the docker container
resource "docker_container" "terraform-app-container" {
  name  = "terraform-app-container"
  image = docker_image.terraform-app-img.name
  ports {
    internal = 80
    external = 4200
  }
  wait_timeout = 100
  restart      = "unless-stopped"

}


