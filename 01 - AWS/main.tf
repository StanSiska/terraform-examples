# 1. Generate credentials for AWS CLI
# 2. cmd: terraform plan for verification

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "terraform_first_server" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
}