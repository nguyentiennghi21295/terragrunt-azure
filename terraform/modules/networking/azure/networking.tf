resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]

  tags = {
    Environment = var.environment
    Region      = var.rg_location
  }
}

# Subnet 1 resource
resource "azurerm_subnet" "subnet_01" {
  name                 = "subnet-01"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subnet 2 resource
resource "azurerm_subnet" "subnet_02" {
  name                 = "subnet-02"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Network Security Group resource
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.environment}"
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  # Allow RDP (Port 3389)
  security_rule {
    name                       = "Allow-RDP"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  # Allow FTP (Port 21)
  security_rule {
    name                       = "Allow-FTP"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "21"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  # Allow custom port (e.g., 8080)
  security_rule {
    name                       = "Allow-Custom-8080"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environment
    Region      = var.rg_location
  }
}

# Associate NSG with all NICs
resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  for_each                 = toset(var.vm_vms)
  network_interface_id     = azurerm_network_interface.vm_nics[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Public IPs for each VM
resource "azurerm_public_ip" "public_ip" {
  for_each            = toset(var.vm_vms)
  name                = "public-ip-${var.prefix}-${each.key}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment
    Region      = var.rg_location
  }
}

# Networking for each VM NIC
resource "azurerm_network_interface" "vm_nics" {
  for_each            = toset(var.vm_vms)
  name                = "${var.prefix}-${each.key}-nic"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_01.id
    private_ip_address_allocation = "Dynamic"
    primary                      = false
  }

  ip_configuration {
    name                          = "external"
    subnet_id                     = azurerm_subnet.subnet_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
    primary                      = true
  }

  tags = {
    Environment = var.environment
    Role        = each.key
  }
}