resource "aws_db_subnet_group" "default" {
  name        = "default_subnet_group"
  description = "The default subnet group for all DBs in this architecture"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
  ]

  tags = {
    env = "test"
  }
}

resource "aws_db_parameter_group" "log_db_parameter" {
  name   = "logs"
  family = "postgres16"

  parameter {
    value = "1"
    name  = "log_connections"
  }

  tags = {
    env = "test"
  }
}


resource "aws_db_instance" "db1" {
  username                = "nikola"
  skip_final_snapshot     = true
  publicly_accessible     = false
  password                = var.db_password
  parameter_group_name    = aws_db_parameter_group.log_db_parameter.name
  instance_class          = var.instance_class
  engine_version          = "16.1"
  db_name                 = "test"
  engine                  = "postgres"
  db_subnet_group_name    = aws_db_subnet_group.default.name
  backup_retention_period = 1 #1 day backup
  allocated_storage       = 50
  multi_az                = true

  tags = {
    env = "test"
  }

  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]
}

resource "aws_db_instance" "db_replica" {
  skip_final_snapshot     = true
  replicate_source_db     = aws_db_instance.db1.identifier
  publicly_accessible     = false
  parameter_group_name    = aws_db_parameter_group.log_db_parameter.name
  instance_class          = var.instance_class
  identifier              = "db-replica"
  backup_retention_period = 7
  apply_immediately       = true

  tags = {
    replica = "true"
    env     = "test"
  }

  vpc_security_group_ids = [
    aws_security_group.sg.id,
  ]
}
