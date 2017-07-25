#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

sudo yum -y install httpd git
sudo chkconfig httpd on
sudo service httpd start
