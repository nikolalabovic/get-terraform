variable "db_password" {
  type      = string
  default   = "password"
  sensitive = true
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}
