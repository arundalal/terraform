resource "aws_security_group" "terrvpc_webapp_sg" {
    name = "${var.env}_${var.app}_secgp"
    description = "All web trafic to server"
    vpc_id = "${var.vpc_id}"
    
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    
  }
  tags {
    Name = "${var.env}_${var.app}_secgp"
    Creator = "Terraform"
  }
}