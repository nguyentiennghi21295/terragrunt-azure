# Include root terragrunt.hcl
include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

#terraform {
  source = "${get_parent_terragrunt_dir()}/../terraform/modules//${basename(get_terragrunt_dir())}"
}

dependency "networking" {
  config_path = "../networking"

  # Mock outputs for validation (if needed)
  mock_outputs = {
    vm_nics = {
      "Jenkins-master" = "fake-nic-id-1",
      "Jenkins-slave"  = "fake-nic-id-2",
      "Ansible"        = "fake-nic-id-3"
    }
  }
}

dependencies {
  paths = ["../networking", "../resource-group"]
}



# Values for current module - Specific to this project
inputs = {
  vm_nics = dependency.networking.outputs.vm_nics
  vm_size = "Standard_B1s"
  tags = {
    tier      = "${basename(get_terragrunt_dir())}"
    createdby = "Terragrunt"
    version   = "1.1"
  }
}