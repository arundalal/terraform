resource "aws_instance" "terr_bastion" {
    ami = "ami-b73b63a0"
    instance_type = "t2.micro"
    key_name = "arun"
    subnet_id = "${var.publicsub_id[0]}"
    vpc_security_group_ids = ["${aws_security_group.terrvpc_webapp_sg.id}"]
    associate_public_ip_address = "true"
    tags {
    Name = "${var.env}_bastion"
    Creator = "Terraform"
  }
}

resource "aws_instance" "terr_web" {
    count = 1
    ami = "ami-b73b63a0"
    instance_type = "t2.micro"
    key_name = "arun"
    subnet_id = "${var.privatesub_id[0]}"
    vpc_security_group_ids = ["${aws_security_group.terrvpc_webapp_sg.id}"]
    tags {
    Name = "${var.env}_${var.app}_ec2"
    Creator = "Terraform"
  }
  }
