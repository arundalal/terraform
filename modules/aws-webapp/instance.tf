resource "aws_instance" "TERRA_Bastion" {
    ami = "ami-b73b63a0"
    instance_type = "t2.micro"
    key_name = "arun"
    subnet_id = "${var.Temp_pubsub_id[0]}"
    vpc_security_group_ids = ["${aws_security_group.TERRVPC_WebApp_SG.id}"]
    associate_public_ip_address = "true"
}

resource "aws_instance" "web" {
    count = 2
    ami = "ami-b73b63a0"
    instance_type = "t2.micro"
    key_name = "arun"
    subnet_id = "${var.Temp_prisub_id[0]}"
    vpc_security_group_ids = ["${aws_security_group.TERRVPC_WebApp_SG.id}"]
    
  }
