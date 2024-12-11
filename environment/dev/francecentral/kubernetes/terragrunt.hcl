# Include root terragrunt.hcl
#include "root" {
#  path = find_in_parent_folders("terragrunt.hcl")
#}

#terraform {
#  source = "${get_parent_terragrunt_dir()}/../terraform/modules//${basename(get_terragrunt_dir())}"
#}

#dependencies {
#  paths = ["../resource-group","../networking","../virtualMachines"]
#}


# Values for current module - Specific to this project
#inputs = {
#  tags = {
#    tier      = "${basename(get_terragrunt_dir())}"
#    createdby = "Terragrunt"
#    version   = "1.1"
#  }
#}