terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.0.0"
}

provider "yandex" {
  token     = "t1.9euelZqZksiSxsrLj5udmYyYlZqbmO3rnpWanIyRipSTnJOajZXHnJiPzYzl8_cNNRtL-e9fWDEr_N3z901jGEv5719YMSv8zef1656VmsjOmp6Xz8aVy5aRzI6Zk4mb7_zF656VmsjOmp6Xz8aVy5aRzI6Zk4mb.DDzmBHktbPXHpzUzynJxBf8okmHIaRdh1w8sBPPEhm2f1tHJXM1PpP-JL60LxapY9eAmI7Fzkl0lZqhA-1GKDQ"
  cloud_id  = "b1g31ab21b32dog1ps4c"  # Замените на ваш реальный cloud_id
  folder_id = "b1gam4o6rj97es4peaq4"  # Замените на ваш реальный folder_id
  zone      = "ru-central1-a"  # Укажите вашу зону
}
