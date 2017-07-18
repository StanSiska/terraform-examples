# 1. Generate credentials for AWS CLI
# 2. cmd: terraform plan -- verification/sanity check, similar to diff
# 3. cmd: terraform apply - creates instance

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "terraform_first_server" {
  ami = "ami-82be18ed"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "This is Terraformed AMI ami-82be18ed (Amzn Linux 2017.03.1) > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags {
    Name = "terraform_amazon_linux"
    CostCenter = "None"
  }
}