# 1. Generate credentials for AWS CLI
# 2. cmd: terraform plan -- verification/sanity check, similar to diff
# 3. cmd: terraform apply - creates instance

# NOTE 01: The <<-EOF and EOF are Terraform’s heredoc syntax, which allows you to create multiline strings
# without having to insert newline characters all over the place.

# Interpolation syntax = "${something_to_interpolate}" for extracting attributes
# Example "${TYPE.NAME.ATTRIBUTE}"

# cmd: terraform graph - generates graph in DOT syntax . Open in GraphVizOnline
# http://dreampuf.github.io/GraphvizOnline/
provider "aws" {
  region = "eu-central-1"
}

# Define server_port as variable, used later in configuration (DRY - Dont Repeat Yourself)
variable "server_port" {
  description = "The port for Apache HTTP Server"
  default = 80
}

# Displays public_ip value after APPLY command
# or use cmd: terraform output <OUTPUT_NAME>
output "public_ip" {
  value = "${aws_instance.terraform_first_server.public_ip}"
}

resource "aws_security_group" "instance" {
  name = "terraform-secgroup-instance"
  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "terraform_first_server" {
  ami = "ami-82be18ed"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum -y install httpd git
              sudo echo "This is Terraformed AMI ami-82be18ed (Amzn Linux 2017.03.1)" > /var/www/html/index.html
              sudo chkconfig httpd on
              sudo service httpd start
              EOF

  tags {
    Name = "terraform_amazon_linux"
    CostCenter = "None"
  }
}