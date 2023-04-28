#VPC and configurations
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
  default = "us-west-2b"
}

variable "az_c" {
  type    = string
  default = "us-west-2c"
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
