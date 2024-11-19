# Output for Virtual Network ID
output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of the created Virtual Network"
}

# Output for Subnet 1 ID
output "subnet_01_id" {
  value       = azurerm_subnet.subnet_01.id
  description = "ID of Subnet 1"
}

# Output for Subnet 2 ID
output "subnet_02_id" {
  value       = azurerm_subnet.subnet_02.id
  description = "ID of Subnet 2"
}

# Output for Network Security Group ID
output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "ID of the Network Security Group"
}

# Output for Public IPs
output "public_ips" {
  value = {
    for name, ip in azurerm_public_ip.public_ip :
    name => ip.ip_address
  }
  description = "Map of public IP addresses for each VM role"
}

# Output for Network Interface IDs
output "nic_ids" {
  value = {
    for vm_role, nic in azurerm_network_interface.vm_nics :
    vm_role => nic.id
  }
  description = "Map of Network Interface IDs for each VM role"
}

# Corrected output for Network Interface IDs (used by virtual machines)
output "vm_nics" {
  value = {
    for role, nic in azurerm_network_interface.vm_nics :
    role => nic.id
  }
  description = "Map of Network Interface IDs for each VM role"
}