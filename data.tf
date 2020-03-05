provider "aws" {
    region     = "us-east-2"
    access_key = "AKIA6J22H4VXOPWJU6HC"
    secret_key = "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"
  
}


data "aws_security_group" "mygroup" {
    name = "default"


}


resource "aws_instance" "vmmachine" {
  ami =  " ami-0fc20dd1da406780b"
  instance_type = "t2.micro"
  key_name = "ubuntu"
  security_groups = ["${data.aws_security_group.mygroup.name}"]

  connection {
      type = "ssh"
      user = "ubuntu"
      host     = "${aws_instance.vmmachine.public_ip}"
      private_key = "${file("./ubuntu.pem")}"
  }
  provisioner "remote-exec" {
        inline = ["sudo apt-get update", "sudo apt-get install openjdk-8-jdk -y","sudo apt-get install chocolatey -y"]
    }

  
}






