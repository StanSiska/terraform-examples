provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "first_server" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
}