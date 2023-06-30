# Creazione del network security group
resource "azurerm_network_security_group" "subnet_nsg" {
  name                = "subnet-nsg"
  location            = "westeurope"
  resource_group_name = data.azurerm_resource_group.lab_rg.name

  tags = {
    environment = "production"
    project     = "iac-iannelli"
    owner       = "gioele-iannelli"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "62.94.92.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPinbound"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "62.94.92.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Creazione della subnet
resource "azurerm_subnet" "tf_ianniac_subnet" {
  name                 = "tf-ianniac-subnet"
  resource_group_name  = data.azurerm_resource_group.lab_rg.name
  virtual_network_name = data.azurerm_virtual_network.lab_vnet.name
  address_prefixes     = ["10.0.6.0/24"]
}

# Associazione tra subnet e network security group
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_nic" {
  subnet_id                 = azurerm_subnet.tf_ianniac_subnet.id
  network_security_group_id = azurerm_network_security_group.subnet_nsg.id
}

# Creazione dell'indirizzo ip pubblico
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vm-public-ip"
  location            = "westeurope"
  resource_group_name = data.azurerm_resource_group.lab_rg.name
  allocation_method   = "Static"

  tags = {
    environment = "production"
    project     = "iac-iannelli"
    owner       = "gioele-iannelli"
  }
}

# Creazione dell'interfaccia di rete
resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-nic"
  location            = "westeurope"
  resource_group_name = data.azurerm_resource_group.lab_rg.name
  
  tags = {
    environment = "production"
    project     = "iac-iannelli"
    owner       = "gioele-iannelli"
  }
  ip_configuration {
    name                          = "vm-ip-config"
    subnet_id                     = azurerm_subnet.tf_ianniac_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_public_ip.id
  }
}