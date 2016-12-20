resource "aws_route_table" "TERRVPC_PublicRoute" {
    vpc_id = "${aws_vpc.TERRVPC.id}"
    tags {
        Name = "${var.PubRoute}"
    }
}

resource "aws_route_table" "TERRVPC_PrivateRoute" {
    vpc_id = "${aws_vpc.TERRVPC.id}"
    tags {
        Name = "${var.PriRoute}"
    }
}

resource "aws_route_table_association" "TERRVPC_PubAssoc_1" {
    subnet_id = "${aws_subnet.PublicSub_1.id}"
    route_table_id = "${aws_route_table.TERRVPC_PublicRoute.id}"
}

resource "aws_route_table_association" "TERRVPC_PubAssoc_2" {
    subnet_id = "${aws_subnet.PublicSub_2.id}"
    route_table_id = "${aws_route_table.TERRVPC_PublicRoute.id}"
}

resource "aws_route_table_association" "TERRVPC_PriAssoc_1" {
    subnet_id = "${aws_subnet.PrivateSub_1.id}"
    route_table_id = "${aws_route_table.TERRVPC_PrivateRoute.id}"
}

resource "aws_route_table_association" "TERRVPC_PriAssoc_2" {
    subnet_id = "${aws_subnet.PrivateSub_2.id}"
    route_table_id = "${aws_route_table.TERRVPC_PrivateRoute.id}"
}

resource "aws_route" "TERRVPC_Pub_Route" {
    route_table_id = "${aws_route_table.TERRVPC_PublicRoute.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.TERRVPC_IGW.id}"
    depends_on = ["aws_route_table.TERRVPC_PublicRoute"]
}

resource "aws_route" "BetaVPC_Pri_Route" {
    route_table_id = "${aws_route_table.TERRVPC_PrivateRoute.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.TERRVPC_NGW_1.id}"
    depends_on = ["aws_route_table.TERRVPC_PrivateRoute"]
}
