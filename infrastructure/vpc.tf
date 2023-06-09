resource "aws_vpc" "bml" {
  cidr_block           = var.cidr_vpc
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns
  enable_dns_hostnames = var.enable_dns

  tags = {
    Name = "bml"
  }
}

resource "aws_subnet" "bml_public_a" {
  vpc_id                  = aws_vpc.bml.id
  cidr_block              = var.cidr_pub_a
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.az_a

  tags = {
    Name = "bml_public_a"
  }
}

resource "aws_subnet" "bml_public_b" {
  vpc_id                  = aws_vpc.bml.id
  cidr_block              = var.cidr_pub_b
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.az_b

  tags = {
    Name = "bml_public_b"
  }
}

resource "aws_subnet" "bml_app_a" {
  vpc_id                  = aws_vpc.bml.id
  cidr_block              = var.cidr_app_a
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone       = var.az_c

  tags = {
    Name = "bml_app_a"
  }
}

resource "aws_subnet" "bml_app_b" {
  vpc_id                  = aws_vpc.bml.id
  cidr_block              = var.cidr_app_b
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone       = var.az_a

  tags = {
    Name = "bml_app_b"
  }
}

resource "aws_subnet" "bml_db_a" {
  vpc_id                  = aws_vpc.bml.id
  cidr_block              = var.cidr_db_a
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone       = var.az_b

  tags = {
    Name = "bml_db_a"
  }
}

resource "aws_subnet" "bml_db_b" {
  vpc_id                  = aws_vpc.bml.id
  cidr_block              = var.cidr_db_b
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone       = var.az_c

  tags = {
    Name = "bml_db_b"
  }
}


# internet gateway 
resource "aws_internet_gateway" "bml_igw" {
  vpc_id = aws_vpc.bml.id

  tags = {
    Name = "bml_igw"
  }
}


# route table and assostation 
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.bml.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bml_igw.id
  }

  tags = {
    Name = "bml_igw"
  }
}

resource "aws_route_table_association" "frontend" {
  subnet_id      = aws_subnet.bml_public_a.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "frontend_b" {
  subnet_id      = aws_subnet.bml_public_a.id
  route_table_id = aws_route_table.public_rtb.id
}

# nat gw
resource "aws_eip" "bml_eip" {
  vpc = "true"
}
resource "aws_nat_gateway" "bml_ngw" {
  allocation_id = aws_eip.bml_eip.id
  subnet_id     = aws_subnet.bml_public_a.id
}

# VPC setup for NAT
resource "aws_route_table" "bml_private_rtb" {
  vpc_id = aws_vpc.bml.id

  tags = {
    Name = "private_rtb"
  }
}

# route associations private
resource "aws_route_table_association" "backend_app_a" {
  subnet_id      = aws_subnet.bml_app_a.id
  route_table_id = aws_route_table.bml_private_rtb.id
}

resource "aws_route_table_association" "backend_app_b" {
  subnet_id      = aws_subnet.bml_app_b.id
  route_table_id = aws_route_table.bml_private_rtb.id
}

resource "aws_route_table_association" "backend_db_a" {
  subnet_id      = aws_subnet.bml_db_a.id
  route_table_id = aws_route_table.bml_private_rtb.id
}

resource "aws_route_table_association" "backend_db_b" {
  subnet_id      = aws_subnet.bml_db_b.id
  route_table_id = aws_route_table.bml_private_rtb.id
}


