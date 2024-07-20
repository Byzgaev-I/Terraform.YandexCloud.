# Домашнее задание "`«Основы Terraform. Yandex Cloud»`"   

---

### Задание 1

В качестве ответа всегда полностью прикладывайте ваш terraform-код в git. Убедитесь что ваша версия Terraform ~>1.8.4

1) Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2) Создайте сервисный аккаунт и ключ. service_account_key_file.
3) Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную vms_ssh_public_root_key.
4) Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5) Подключитесь к консоли ВМ через ssh и выполните команду  curl ifconfig.me. Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address". Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: eval $(ssh-agent) && ssh-add Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
6) Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

### Выполнения задания 1

1) Изучил проект.

2) Переименовал файл personal.auto.tfvars_example в personal.auto.tfvars, заполнил переменные.

3) Создал короткий ssh ключ используя ssh-keygen -t ed25519, записал его pub часть в переменную vms_ssh_root_key.

4) Инициализировал проект, выполнил код. Нашел ошибки в блоке resource "yandex_compute_instance" "platform" {.

Выявленные ошибки:  

- В строке platform_id = "standart-v4" правильно писать standard
- Вместо версии v4 могут быть только v1, v2 и v3.
- Cores 1 не может быть, потомучто согласно документации минимальное количество виртуальных ядер процессора для всех платформ равно двум.

5)
  
![image.jpg](https://github.com/Byzgaev-I/Terraform.YandexCloud./blob/main/1-2.png)


![image.jpg](https://github.com/Byzgaev-I/Terraform.YandexCloud./blob/main/1.png)


![image.jpg](https://github.com/Byzgaev-I/Terraform.YandexCloud./blob/main/1-3.png)

6) Параметры  preemptible = true - это прерываемая ВМ, т.е. работает не более 24 часов и может быть остановлена Compute Cloud в любой момент.  
Параметр core_fraction = 5 - указывает базовую производительность ядра в процентах. Указывается для экономии ресурсов.

---

### Задание 2

1) Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.
2) Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
3) Проверьте terraform plan. Изменений быть не должно.

### Выполнения задания 2


1) Заменил хардкод-значения для ресурсов yandex_compute_instance на переменные и добавил префикс vm_web_.

   Обновленный main.tf
   
```hcl
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id
  zone        = var.vm_web_zone

  resources {
    core_fraction = var.vm_web_core_fraction
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_web_image_id
      type     = var.vm_web_disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = {
    "serial-port-enable" = var.vm_web_serial_port_enable
    "ssh-keys"           = var.vm_web_ssh_keys
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
}

output "external_ip_address" {
  value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
}

output "instance_id" {
  value = yandex_compute_instance.platform.id
}

```


Обновленный variables.tf

```bash
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of the VM"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for the VM"
}

variable "vm_web_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone where the VM will be created"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "Core fraction for the VM"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "Number of cores for the VM"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory size (in GB) for the VM"
}

variable "vm_web_image_id" {
  type        = string
  default     = "fd8t24r7o6m7fdvlp47l"
  description = "Image ID for the boot disk"
}

variable "vm_web_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Type of the boot disk"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Enable NAT for the VM"
}

variable "vm_web_serial_port_enable" {
  type        = string
  default     = "1"
  description = "Enable serial port for the VM"
}

variable "vm_web_ssh_keys" {
  type        = string
  default     = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICMLupjJ1DJ6oImS9OyvFFNenNk8/hiRrzkWIZ171DFa root@debian12-2"
  description = "SSH keys for the VM"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemptible flag for the VM"
}


```

![image.jpg](https://github.com/Byzgaev-I/Terraform.YandexCloud./blob/main/2.png)
