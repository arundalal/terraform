resource "aws_security_group" "terr_vpc_db_sg" {
    name = "${var.dbname}db_secgp"
    description = "All trafic to DB server"
    vpc_id = "${var.vpc_id}"
    
    ingress {
      from_port = 3306
      to_port = 3306
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

resource "aws_db_subnet_group" "terrdb_subnet_gp" {
    name = "${var.dbname}db_subnet_gp"
    subnet_ids = ["${var.prisub_id[0]}", "${var.prisub_id[1]}"]
    tags {
        Name = "Environment subnet grp"
    }
}

resource "aws_db_instance" "TERRDB" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.6.27"
  instance_class       = "db.t2.micro"
  identifier           = "${var.dbname}"
  username             = "masteruser"
  password             = "password"
  db_subnet_group_name = "${aws_db_subnet_group.terrdb_subnet_gp.id}"
  parameter_group_name = "default.mysql5.6"
  vpc_security_group_ids = ["${aws_security_group.terr_vpc_db_sg.id}"]
}