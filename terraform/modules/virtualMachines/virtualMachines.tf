# Virtual machine resource for Jenkins Master, Jenkins Slave, and Ansible
resource "azurerm_linux_virtual_machine" "servers" {
  for_each            = toset(["Jenkins-master", "Jenkins-slave", "Ansible"]) # Three VMs for Jenkins Master, Slave, and Ansible
  # for_each            = toset(["Jenkins-master"]) # Three VMs for Jenkins Master, Slave, and Ansible
  name                = each.key
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = var.vm_size # Smaller instance size for free tier
  admin_username      = "adminuser"
  network_interface_ids = [
    var.vm_nics[each.key]
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/public_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    Environment = var.environment
    Name        = each.key
  }
}