# Output for Virtual Machine IDs
output "vm_ids" {
  value = {
    for vm_role, vm in azurerm_linux_virtual_machine.servers :
    vm_role => vm.id
  }
  description = "Map of Virtual Machine IDs for each role"
}

# Output for Virtual Machine Names
output "vm_names" {
  value = {
    for vm_role, vm in azurerm_linux_virtual_machine.servers :
    vm_role => vm.name
  }
  description = "Map of Virtual Machine names for each role"
}

# # Output for Private IP Addresses of VMs
# output "vm_private_ips" {
#   value = {
#     for vm_role, nic in azurerm_network_interface.vm_nics :
#     vm_role => nic.private_ip_address
#   }
#   description = "Map of private IP addresses for each Virtual Machine"
# }

# # Output for Public IP Addresses (if available)
# output "vm_public_ips" {
#   value = {
#     for vm_role, ip in azurerm_public_ip.public_ip :
#     vm_role => ip.ip_address
#   }
#   description = "Map of public IP addresses for each Virtual Machine role"
# }

# Output for Source Image Reference
output "vm_image_reference" {
  value       = azurerm_linux_virtual_machine.servers["Jenkins-master"].source_image_reference
  description = "Source image reference used for the Virtual Machines"
}

# Output for Virtual Machine Tags
output "vm_tags" {
  value = {
    for vm_role, vm in azurerm_linux_virtual_machine.servers :
    vm_role => vm.tags
  }
  description = "Tags associated with each Virtual Machine"
}