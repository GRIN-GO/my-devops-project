terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

# Просто ссылаемся на уже собранный образ
resource "docker_image" "app" {
  name         = "my-devops-app:v2"
  keep_locally = true
}

# Поднимаем контейнер
resource "docker_container" "app" {
  name  = "my-devops-terraform-container"
  image = docker_image.app.image_id

  ports {
    internal = 80
    external = 8091
  }
}

output "app_url" {
  value       = "http://localhost:8091"
  description = "URL приложения, управляемого через Terraform"
}