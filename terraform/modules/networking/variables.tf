variable "rg_name" {
  default = ""
  type    = string
}

variable "vnet_name" {
  default = ""
  type    = string
}

variable "rg_location" {
  default = ""
  type    = string
}

variable "environment" {
  default = ""
  type    = string
}

variable "prefix" {
  default = ""
  type    = string
}

variable "tags" {
  type = map
}

variable "vm_vms" {
  type    = list(string)
  # default = ["Jenkins-master", "Ansible"]
  default = ["Jenkins-master", "Jenkins-slave", "Ansible"]
}