terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.5"
}

provider "yandex" {
  token     = var.token
  cloud_id  = "b1g31ab21b32dog1ps4c"  # Замените на ваш реальный cloud_id
  folder_id = "b1gam4o6rj97es4peaq4"  # Замените на ваш реальный folder_id
  zone      = "ru-central1-a"  # Укажите вашу зону
}
