resource "aws_db_subnet_group" "bml_sg" {
  name       = var.Name
  subnet_ids = [var.db_subnet_id_b, var.db_subnet_id_a]

  tags = {
    Name = "bml_sg"
  }
}


resource "aws_db_instance" "db_bml_a" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  db_subnet_group_name = var.subnet_group
}

