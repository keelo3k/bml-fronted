#VPC and configurations
variable "vpc_id" {
  type    = string
  default = "bml"
}

variable "cidr_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "enable_dns" {
  type    = string
  default = "true"
}

#AZs
variable "az_a" {
  type    = string
  default = "us-west-2a"
}

variable "az_b" {
  type    = string
  default = "us_west_2b"
}

variable "az_c" {
  type    = string
  default = "us_west_2c"
}


#subnet configurations (map public ip)
variable "map_public_ip_on_launch" {
  type    = string
  default = "true"
}

variable "map_public_ip_on_launch_false" {
  type    = string
  default = "false"
}

#cidr block
variable "cidr_pub_a" {
  type    = string
  default = "10.0.1.0/24"
}

variable "cidr_pub_b" {
  type    = string
  default = "10.0.2.0/24"
}

variable "cidr_app_a" {
  type    = string
  default = "10.0.3.0/24"
}

variable "cidr_app_b" {
  type    = string
  default = "10.0.4.0/24"
}

variable "cidr_db_a" {
  type    = string
  default = "10.0.5.0/24"
}
variable "cidr_db_b" {
  type    = string
  default = "10.0.6.0/24"
}

#subnet 
variable "pub_subnet_id_a" {
  type    = string
  default = "aws_subent.bml_public_a"
}

variable "pub_subnet_id_b" {
  type    = string
  default = "aws_subnet.bml_public_b"
}

variable "app_subnet_id_a" {
  type    = string
  default = "aws_subnet.bml_app_a"
}

variable "app_subnet_id_b" {
  type    = string
  default = "aws_subnet.bml_app_b"
}

variable "db_subnet_id_a" {
  type    = string
  default = "aws_subnet.bml_db_a"
}

variable "db_subnet_id_b" {
  type    = string
  default = "aws_subnet.bml_db_b"
}

#route table
variable "public_rtb" {
  type    = string
  default = "aws_route_table.bml_rtb_pub"
}

variable "private_rtb" {
  type    = string
  default = "aws_route_table.bml_rtb_priv"
}

#route table assosation 
variable "public_rtb_association" {
  type    = string
  default = ""
}

variable "private_rtb_association" {
  type    = string
  default = ""
}


#IGW
variable "aws_internet_gateway_id" {
  type    = string
  default = "aws_internet_gateway.bml_igw"
}

variable "cidr_igw" {
  type    = string
  default = "0.0.0.0/0"
}

# nat gw
variable "accept_eip" {
  type    = string
  default = "true"
}

variable "aws_eip" {
  type    = string
  default = "bml_eip"
}


variable "ngw" {
  type    = string
  default = "bml-ngw"
}