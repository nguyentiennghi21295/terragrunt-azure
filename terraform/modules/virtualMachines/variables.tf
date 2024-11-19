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

variable "vm_size" {
  default = ""
  type    = string
}

variable "admin_username" {
  default = ""
  type    = string
}

variable "vm_nics" {
  description = "Map of network interface IDs for each virtual machine"
  type = map
}

variable "vm_vms" {
  type    = list(string)
  default = ["Jenkins-master", "Jenkins-slave", "Ansible"]
}

variable "tags" {
  type = map
}

