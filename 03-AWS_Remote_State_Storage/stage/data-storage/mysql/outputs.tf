# Expose output variables - Address and port
output "address" {
  value = "${aws_db_instance.example.address}"
}
output "port" {
  value = "${aws_db_instance.example.port}"
}