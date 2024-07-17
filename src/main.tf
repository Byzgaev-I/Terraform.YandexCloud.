resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


resource "yandex_vpc_subnet" "develop1" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_zone_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
}



data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform
  metadata = var.metadata_ssh


  resources {
    cores         = var.vm_resource.vm_web_resources.cores
    memory        = var.vm_resource.vm_web_resources.memory
    core_fraction = var.vm_resource.vm_web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
}


data "yandex_compute_image" "ubuntu2" {
  family = var.vm_web_image
}



resource "yandex_compute_instance" "platform2" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform
  zone        = "ru-central1-b"
  metadata = var.metadata_ssh

  resources {
    cores         = var.vm_resource.vm_db_resources.cores
    memory        = var.vm_resource.vm_db_resources.memory
    core_fraction = var.vm_resource.vm_db_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop1.id
    nat       = true
  }

}