###cloud vars
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


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHS1GKF9aYxPZ9/wD5aV0vNax5kVAbFPQ+8DlguBBkE bctrans@ya.ru"
  description = "ssh-keygen -t ed25519"
}

variable "netology-develop-platform" {
  type = string
  default     = "netology"
}

variable "env" {
  type = string
  default     = "develop"
}

variable "project" {
  type = string
  default     = "platform"
}

variable "role" {
   type = string
   default = "web"
}

variable "role1" {
   type = string
   default = "db"
}