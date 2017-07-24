# Define server_port as variable, used later in configuration (DRY - Dont Repeat Yourself)
variable "server_port" {
  description = "The port for Apache HTTP Server"
  default = 8080
}