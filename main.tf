provider "aws" {
  region = var.region
}

resource "aws_vpc" "main_vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "DwcHq"
  }
}

#Subnet Section
resource "aws_subnet" "public_subnet01" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "me-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet01"
  }
}

resource "aws_subnet" "public_subnet02" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "me-central-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet02"
  }
}

resource "aws_subnet" "private_subnet01" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.1.3.0/24"
  availability_zone       = "me-central-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet01"
  }
}
#Route Table Section for Private
resource "aws_route_table" "private_route_table01" {
  vpc_id = aws_vpc.main_vpc.id
  route = []
  tags = {
    Name = "private_route_table"
  }
}

# Route Table Association for Private Subnet
resource "aws_route_table_association" "private_route_table_association01" {
  subnet_id      = aws_subnet.private_subnet01.id
  route_table_id = aws_route_table.private_route_table01.id
}

#resource "aws_route" "private_subnet_route" {
#  route_table_id         = aws_route_table.private_route_table01.id
#  destination_cidr_block = "10.1.0.0/16"
#
#}

# Outputs Section

output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "The ID of the main VPC"
}

output "vpc_name" {
  value       = aws_vpc.main_vpc.tags.Name
  description = "The name tag of the main VPC"
}

output "public_subnet01_cidr_block" {
  value       = aws_subnet.public_subnet01.cidr_block
  description = "The CIDR block of the public_subnet01."
}

output "public_subnet02_cidr_block" {
  value       = aws_subnet.public_subnet02.cidr_block
  description = "The CIDR block of the public_subnet02."
}

output "private_subnet01_cidr_block" {
  value       = aws_subnet.private_subnet01.cidr_block
  description = "The CIDR block of the private_subnet01."
}

output "private_route_table_id" {
  value       = aws_route_table.private_route_table01.id
  description = "The ID of the private route table."

}