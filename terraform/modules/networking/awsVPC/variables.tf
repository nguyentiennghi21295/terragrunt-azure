variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "route_table_name" {
  description = "Name of the Route Table"
  type        = string
}

variable "subnets" {
  description = "Subnets configuration map"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "allowed_ssh_ips" {
  description = "List of CIDR blocks allowed for SSH"
  type        = list(string)
}

variable "allowed_jenkins_ips" {
  description = "List of CIDR blocks allowed for Jenkins"
  type        = list(string)
}