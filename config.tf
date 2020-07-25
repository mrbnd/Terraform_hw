provider "aws" {
 region = "us-east-2"
}

resource "aws_instance" "example" {
 ami = "ami-0a63f96e85105c6d3"
 instance_type = "t2.micro"
 key_name = "my-key"
 security_groups = ["EC2SecirityGroup1"]
 associate_public_ip_address = "true"

connection {
    type = "ssh"
    user = "ubuntu"
  }

provisioner "file" {
    source      = "index.nginx-debian.html"
    destination = "/tmp/index.nginx-debian.html"
  }

provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo cp /tmp/index.nginx-debian.html /var/www/html/index.nginx-debian.html",
      "sudo service nginx start",
    ]
  }

}