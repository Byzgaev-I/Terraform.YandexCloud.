resource "yandex_vpc_network" "develop" {
  name = "develop"
}

resource "yandex_vpc_subnet" "develop" {
  name           = "develop"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_compute_instance" "platform" {
  name        = "netology-develop-platform-web"
  platform_id = "standard-v1"  # Обновите идентификатор платформы, если нужно
  zone        = "ru-central1-a"

  resources {
    core_fraction = 5
    cores         = 1
    memory        = 1
  }

  boot_disk {
    initialize_params {
      image_id = "fd8t24r7o6m7fdvlp47l"
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    "serial-port-enable" = "1"
    "ssh-keys"           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICMLupjJ1DJ6oImS9OyvFFNenNk8/hiRrzkWIZ171DFa root@debian12-2"
  }

  scheduling_policy {
    preemptible = true
  }
}

output "external_ip_address" {
  value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
}

output "instance_id" {
  value = yandex_compute_instance.platform.id
}
