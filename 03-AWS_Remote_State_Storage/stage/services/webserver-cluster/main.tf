# Interpolation function for File
user_data = "${file("user-data.sh")}"

# Template_file data source - for interpolation accross files
# 2 Parameters:
#    template - string
#    var      - map of variables
# Output parameter:
#    rendered - result of rendering the template incl. interpolation syntax in template with variables available in vars.
#

data "template_file" "user_data" {
  template = "${file("user-data.sh")}"

  vars {
    server_port = "${var.server_port}"
    db_address  = "${data.template_file.user_data.db_address}"
    db_port     = "${data.template_file.user_data.db_port}"
  }
}