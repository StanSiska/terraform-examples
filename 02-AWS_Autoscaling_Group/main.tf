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
# output "public_ip" {
#   value = "${aws_instance.terraform_first_server.public_ip}"
# }

# Lifecycle meta-parameter exists for all ASG (autoscaling group) resources
resource "aws_security_group" "terraform_secgroup_instance" {
  name = "terraform-secgroup-instance"
  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Statement defining which AWS AZs are available
data "aws_availability_zones" "all" {}

resource "aws_autoscaling_group" "terraform_autoscaling_grp" {
  launch_configuration = "${aws_launch_configuration.terraform_launch_config.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  max_size = 1
  min_size = 2

  tag {
    key = "Name"
    value = "terraform-asg-1"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "terraform_launch_config" {
  image_id = "ami-82be18ed"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.terraform_secgroup_instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum -y install httpd git
              sudo echo "This is Terraformed AMI ami-82be18ed (Amzn Linux 2017.03.1)" > /var/www/html/index.html
              sudo chkconfig httpd on
              sudo service httpd start
              EOF

  # Meta-parameter Lifecycle defining how to handle instances
  lifecycle {
    create_before_destroy = true
  }
}