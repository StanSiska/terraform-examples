provider "aws" {
  region = "eu-central-1"
}

# Define server_port as variable, used later in configuration (DRY - Dont Repeat Yourself)
variable "server_port" {
  description = "The port for Apache HTTP Server"
  default = 80
}

# Statement fetching available AWS AZs every time Teraform is started
data "aws_availability_zones" "all" {}

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

# Security group allowing traffic throught port 80 for ELB traffic routing
resource "aws_security_group" "terraform_elb_instance" {
  name = "terraform-elb-instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Elastic Load Balancer configuration
resource "aws_elb" "terraform-elb-1" {
  name = "terraform-elb-example"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  security_groups = ["${aws_security_group.terraform_elb_instance.id}"]

  # Define ELB listening port and routing port & protocol
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}//"
  }
}

# Autoscaling group must contain AZ statement
resource "aws_autoscaling_group" "terraform_autoscaling_grp" {
  launch_configuration = "${aws_launch_configuration.terraform_launch_config.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  load_balancers = ["${aws_elb.terraform-elb-1.name}"]
  health_check_type = "ELB"

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

  user_data = <<-EOF
              #!/bin/bash
              sudo yum -y install httpd git
              sudo echo "This is Terraformed AMI ami-82be18ed (Amzn Linux 2017.03.1)" > /var/www/html/index.html
              sudo chkconfig httpd on
              sudo service httpd start
              EOF

  # Meta-parameter Lifecycle defining how to handle instances
  lifecycle {
    # If set to true, must be set on depending resources (eg. secgrp) to avoid cyclical dependencies
    create_before_destroy = true
  }
}