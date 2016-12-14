provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_vpc" "BetaVPC" {
    cidr_block = "10.10.12.0/24"
    instance_tenancy = "default"
    tags{
        Name = "BetaVPC"
    }
}

resource "aws_subnet" "BetaVPC_PublicSub_B" {
    vpc_id = "${aws_vpc.BetaVPC.id}"
    cidr_block = "10.10.12.0/26"
    availability_zone = "us-east-1b"
    tags {
        Name = "BetaVPC_PublicSub_B"
    }
}

resource "aws_subnet" "BetaVPC_PublicSub_C" {
    vpc_id = "${aws_vpc.BetaVPC.id}"
    cidr_block = "10.10.12.64/26"
    availability_zone = "us-east-1c"
    tags {
        Name = "BetaVPC_PublicSub_C"
    }
}

resource "aws_subnet" "BetaVPC_PrivateSub_B" {
    vpc_id = "${aws_vpc.BetaVPC.id}"
    cidr_block = "10.10.12.128/26"
    availability_zone = "us-east-1b"
    tags {
        Name = "BetaVPC_PrivateSub_B"
    }
}

resource "aws_subnet" "BetaVPC_PrivateSub_C" {
    vpc_id = "${aws_vpc.BetaVPC.id}"
    cidr_block = "10.10.12.192/26"
    availability_zone = "us-east-1c"
    tags {
        Name = "BetaVPC_PrivateSub_C"
    }
}

resource "aws_internet_gateway" "BetaVPC_IGW" {
    vpc_id = "${aws_vpc.BetaVPC.id}"
}

resource "aws_eip" "BetaVPC_EIP_B" {
    vpc = true
}

resource "aws_nat_gateway" "BetaVPC_Subnet_B_IGW" {
    allocation_id = "${aws_eip.BetaVPC_EIP_B.id}"
    subnet_id = "${aws_subnet.BetaVPC_PublicSub_B.id}"
}

resource "aws_route_table" "BetaVPC_PublicRoute" {
    vpc_id = "${aws_vpc.BetaVPC.id}"
    tags {
        Name = "BetaVPC_PublicRoute"
    }
}

resource "aws_route_table" "BetaVPC_PrivateRoute" {
    vpc_id = "${aws_vpc.BetaVPC.id}"
    tags {
        Name = "BetaVPC_PrivateRoute"
    }
}

resource "aws_route_table_association" "BetaVPC_Pub_ASB" {
    subnet_id = "${aws_subnet.BetaVPC_PublicSub_B.id}"
    route_table_id = "${aws_route_table.BetaVPC_PublicRoute.id}"
}

resource "aws_route_table_association" "BetaVPC_Pub_ASC" {
    subnet_id = "${aws_subnet.BetaVPC_PublicSub_C.id}"
    route_table_id = "${aws_route_table.BetaVPC_PublicRoute.id}"
}

resource "aws_route_table_association" "BetaVPC_Pri_ASB" {
    subnet_id = "${aws_subnet.BetaVPC_PrivateSub_B.id}"
    route_table_id = "${aws_route_table.BetaVPC_PrivateRoute.id}"
}

resource "aws_route_table_association" "BetaVPC_Pri_ASC" {
    subnet_id = "${aws_subnet.BetaVPC_PrivateSub_C.id}"
    route_table_id = "${aws_route_table.BetaVPC_PrivateRoute.id}"
}

resource "aws_route" "BetaVPC_Pub_Route" {
    route_table_id = "${aws_route_table.BetaVPC_PublicRoute.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.BetaVPC_IGW.id}"
    depends_on = ["aws_route_table.BetaVPC_PublicRoute"]
}

resource "aws_route" "BetaVPC_Pri_Route" {
    route_table_id = "${aws_route_table.BetaVPC_PrivateRoute.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.BetaVPC_Subnet_B_IGW.id}"
    depends_on = ["aws_route_table.BetaVPC_PublicRoute"]
}

resource "aws_security_group" "BetaVPC_WebApp_SG" {
    name = "BetaVPC_WebApp_SG"
    description = "All web trafic to server"
    vpc_id = "${aws_vpc.BetaVPC.id}"
    
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
resource "aws_instance" "Beta_Bastion" {
    ami = "ami-b73b63a0"
    instance_type = "t2.micro"
    key_name = "arun"
    subnet_id = "${aws_subnet.BetaVPC_PublicSub_B.id}"
    vpc_security_group_ids = ["${aws_security_group.BetaVPC_WebApp_SG.id}"]
    associate_public_ip_address = "true"
}

resource "aws_instance" "web" {
    count = 2
    ami = "ami-b73b63a0"
    instance_type = "t2.micro"
    key_name = "arun"
    subnet_id = "${aws_subnet.BetaVPC_PrivateSub_B.id}"
    vpc_security_group_ids = ["${aws_security_group.BetaVPC_WebApp_SG.id}"]
    provisioner "chef"  {
        attributes_json = <<-EOF
        {
            "key": "value",
            "app": {
                "cluster1": {
                    "nodes": [
                        "webserver1",
                        "webserver2"
                    ]
                }
            }
        }
        EOF
        environment = "_default"
        run_list = ["recipe[wpblog]"]
        node_name = "webserver1"
        secret_key = "${file("/home/ubuntu/workspace/workdir/chef-repo/.chef/encrypted_data_bag_secret")}"
        server_url = "https://api.opscode.com/organizations/adalal"
        recreate_client = true
        user_name = "arundalal786"
        user_key = "${file("/home/ubuntu/workspace/workdir/chef-repo/.chef/arundalal786.pem")}"
        connection {
        type = "ssh"
        user = "ec2-user"
        bastion_host = "${aws_instance.Beta_Bastion.public_ip}"
        bastion_port = "22"
        private_key = "${file("/home/ubuntu/arun.pem")}"
      }
    
    }
  }
  
# Create a new load balancer
resource "aws_elb" "BetaVPC_Webapp_ELB" {
  name = "BetaVPC-Webapp-ELB"
  subnets = ["${aws_subnet.BetaVPC_PublicSub_B.id}", "${aws_subnet.BetaVPC_PublicSub_C.id}"]
  security_groups = ["${aws_security_group.BetaVPC_WebApp_SG.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:80"
    interval = 30
  }

  instances = ["${aws_instance.web.*.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "BetaVPC-Webapp-ELB"
  }
}


resource "aws_route53_zone" "BetaVPC_Zone" {
    name = "opsguide.info"
}

resource "aws_route53_record" "Beta" {
    zone_id = "${aws_route53_zone.BetaVPC_Zone.zone_id}"
    name = "beta.opsguide.info"
    type = "CNAME"
    ttl = "60"
    records = [
        "${aws_elb.BetaVPC_Webapp_ELB.dns_name}"
    ]
}