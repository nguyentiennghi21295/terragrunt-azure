variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    type = string
    default = "ddp"
}

variable "vpc_security_group_ids" {
    type = list(string)
}

variable "subnet_id" {
    type = string
}