variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image_yandex_cloud"
}

variable "vm_web_name" {
  type = string
  default = "netology-develop-platform-web"
  description = "Name_VM"
}

variable "vm_web_platform" {
  type = string
  default = "standard-v1"
  description = "platform_id"
}

#variable "vm_web_core" {
  #type = string
  #default = "2"
  #description = "CPU"
#}

#variable "vm_web_memory" {
  #type = string
  #default = "1"
  #description = "RAM"
#}

#variable "vm_web_core_fraction" {
  #type = string
  #default = "5"
  #description = "core_fraction"
#}

variable "vm_db_image" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "vm_db_name" {
  type = string
  default = "netology-develop-platform-db"
}

variable "vm_db_platform" {
  type = string
  default = "standard-v1"
}

#variable "vm_db_core" {
  #type = string
  #default = "2"
#}

#variable "vm_db_memory" {
  #type = string
  #default = "2"
#}

#variable "vm_db_fraction" {
  #type = string
  #default = "20"
#}


variable "vm_db_zone_b" {
  type        = string
  default     = "ru-central1-b"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop1"
  description = "VPC network & subnet name"
}

variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.1.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


variable "vm_resource" {
  description = "ALL Vm's"
  type = map(map(number))
  default = {
    vm_web_resources = {
      cores = 2
      memory = 1
      core_fraction = 5
    }


    vm_db_resources = {
      cores = 2
      memory = 2
      core_fraction = 20
    }
  }
}

variable "metadata_ssh" {
  description = "metadata for all vms"
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys          = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHS1GKF9aYxPZ9/wD5aV0vNax5kVAbFPQ+8DlguBBkE bctrans@yandex.ru"
  }
}
