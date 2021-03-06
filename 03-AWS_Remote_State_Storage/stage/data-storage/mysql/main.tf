provider "aws" {
  region = "eu-central-1"
}
resource "aws_db_instance" "example" {
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "example_tf_database"
  username = "admin"
  password = "${var.db_password}"
}