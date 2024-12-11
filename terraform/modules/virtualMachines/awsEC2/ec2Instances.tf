data "aws_ami" "ubuntu_latest" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }


}

resource "aws_instance" "demo-server" {
    ami                     = data.aws_ami.ubuntu_latest.id
    instance_type           = var.instance_type
    key_name                = var.key_name
    vpc_security_group_ids  = var.vpc_security_group_ids
    subnet_id               = var.subnet_id
    for_each                = toset(["jenkins_master", "build_slave", "ansible"])
    tags                    = {
        Name = each.key 
    }
}