resource "aws_vpc" "bml" {
  cidr_block = var.cidr_vpc
  instance_tenancy = var.instance_tenancy
  enable_dns_support   = var.enable_dns
  enable_dns_hostnames = var.enable_dns
  
  tags = {
  Name = "bml"
  }
}

resource "aws_subnet" "bml_public_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_pub_a
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.az_a

  tags = {
    Name = "bml_public_a"
  }
}

resource "aws_subnet" "bml_public_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_pub_b
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = var.az_b

  tags = {
    Name = "bml_public_b"
  }
}

resource "aws_subnet" "bml_app_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_app_a
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone = var.az_c

  tags = {
    Name = "bml_app_a"
  }
}

resource  "aws_subnet" "bml_app_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_app_b
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone = var.az_a

  tags = {
    Name = "bml_app_b"
  }
}

resource "aws_subnet" "bml_db_a" {
  vpc_id               = var.vpc_id
  cidr_block           = var.cidr_db_a
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone = var.az_b

  tags = {
    Name = "bml_db_a"
  } 
}

resource "aws_subnet" "bml_db_b" {
  vpc_id               = var.vpc_id
  cidr_block           = var.cidr_db_b
  map_public_ip_on_launch = var.map_public_ip_on_launch_false
  availability_zone = var.az_c

  tags = {
    Name = "bml_db_b"
  } 
}


# internet gateway 
resource "aws_internet_gateway" "bml_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "bml_igw"
  }
}


# route table and assostation 
resource "aws_route_table" "public_rtb" { 
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_igw
    gateway_id = var.aws_internet_gateway_id
  }

  tags = {
    Name = "bml_igw"
  }
}

resource "aws_route_table_association" "frontend" {
  subnet_id      = var.pub_subnet_id_a
  route_table_id = var.public_rtb
}

resource "aws_route_table_association" "frontend_b" {
  subnet_id       = var.pub_subnet_id_b
  route_table_id = var.public_rtb
}

 # nat gw
 resource "aws_eip" "bml_eip" {
 vpc = var.accept_eip
 }
 resource "aws_nat_gateway" "" {
 allocation_id = var.aws_eip
  subnet_id = var.pub_subnet_id_a
}

# VPC setup for NAT
resource "aws_route_table" "ucl_defenders" {
   vpc_id = var.vpc_id

   tags = {
    Name = "private_rtb"
  }
}

 # route associations private
 resource "aws_route_table_association" "backend_app_a" {
   subnet_id      = var.app_subnet_id_a
   route_table_id = var.private_rtb
}

 resource "aws_route_table_association" "backend_app_b" {
   subnet_id      = var.app_subnet_id_b
   route_table_id = var.private_rtb
}

resource "aws_route_table_association" "backend_db_a" {
  subnet_id       = var.db_subnet_id_a
  route_table_id  = var.private_rtb
}

resource "aws_route_table_association" "backend_db_b" {
  subnet_id      = var.db_subnet_id_b
  route_table_id = var.private_rtb
}

