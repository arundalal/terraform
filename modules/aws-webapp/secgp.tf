
resource "aws_security_group" "TERRVPC_WebApp_SG" {
    name = "${var.WebApp_SecGP}"
    description = "All web trafic to server"
    vpc_id = "${var.Temp_vpc_id}"
    
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
  
}