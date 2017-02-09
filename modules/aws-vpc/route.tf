resource "aws_route_table" "terr_vpc_publicroute" {
    vpc_id = "${aws_vpc.terr_vpc.id}"
    tags {
        Name = "${var.env}_$(var.app)_publicroute"
        Creator = "Terraform"
    }
}

resource "aws_route_table" "terr_vpc_privateroute" {
    vpc_id = "${aws_vpc.terr_vpc.id}"
    tags {
        Name = "${var.env}_$(var.app)_privateroute"
        Creator = "Terraform"
    }
}

resource "aws_route_table_association" "terr_vpc_pubassoc_1" {
    subnet_id = "${aws_subnet.publicsubnet_1.id}"
    route_table_id = "${aws_route_table.terr_vpc_publicroute.id}"
}

resource "aws_route_table_association" "terr_vpc_pubassoc_2" {
    subnet_id = "${aws_subnet.publicsubnet_2.id}"
    route_table_id = "${aws_route_table.terr_vpc_publicroute.id}"
}

resource "aws_route_table_association" "terr_vpc_priassoc_1" {
    subnet_id = "${aws_subnet.privatesubnet_1.id}"
    route_table_id = "${aws_route_table.terr_vpc_privateroute.id}"
}

resource "aws_route_table_association" "terr_vpc_priassoc_2" {
    subnet_id = "${aws_subnet.privatesubnet_2.id}"
    route_table_id = "${aws_route_table.terr_vpc_privateroute.id}"
}

resource "aws_route" "terrvpc_pub_route" {
    route_table_id = "${aws_route_table.terr_vpc_publicroute.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terrvpc_igw.id}"
    depends_on = ["aws_route_table.terr_vpc_publicroute"]
}

resource "aws_route" "terrvpc_pri_route" {
    route_table_id = "${aws_route_table.terr_vpc_privateroute.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.terrvpc_ngw_1.id}"
    depends_on = ["aws_route_table.terr_vpc_privateroute"]
}
