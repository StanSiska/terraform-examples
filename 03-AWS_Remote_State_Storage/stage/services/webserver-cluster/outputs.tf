# Displays public_ip value after APPLY command
# or use cmd: terraform output <OUTPUT_NAME>
output "elb_dns_name" {
  value = "${aws_elb.terraform-elb-1.dns_name}"
}