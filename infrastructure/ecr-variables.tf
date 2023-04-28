variable "ecr_name" {
  type    = string
  default = "motion_cluster"
}

variable "image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "scan_on_push" {
  type    = string
  default = true
}

#