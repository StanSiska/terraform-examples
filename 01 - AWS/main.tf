# 1. Generate credentials for AWS CLI
# 2. cmd: terraform plan -- verification/sanity check, similar to diff
# 3. cmd: terraform apply - creates instance

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "terraform_first_server" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
}

tags {
  Name = "terraform_ubuntu_16-04"
  CostCenter = "None"
}