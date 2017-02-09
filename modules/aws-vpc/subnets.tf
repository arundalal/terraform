resource "aws_subnet" "publicsubnet_1" {
    vpc_id = "${aws_vpc.terr_vpc.id}"
    cidr_block = "${var.pub_cidr_1}"
    availability_zone = "us-east-1d"
    tags {
        Name = "${var.env}_${var.app}_publicsub_d"
        Creator = "Terraform"
    }
}

resource "aws_subnet" "publicsubnet_2" {
    vpc_id = "${aws_vpc.terr_vpc.id}"
    cidr_block = "${var.pub_cidr_2}"
    availability_zone = "us-east-1c"
    tags {
        Name = "${var.env}_${var.app}_publicsub_c"
        Creator = "Terraform"
    }
}

resource "aws_subnet" "privatesubnet_1" {
    vpc_id = "${aws_vpc.terr_vpc.id}"
    cidr_block = "${var.pri_cidr_1}"
    availability_zone = "us-east-1d"
    tags {
        Name = "${var.env}_${var.app}_publicsub_d"
        Creator = "Terraform"
    }
}

resource "aws_subnet" "privatesubnet_2" {
    vpc_id = "${aws_vpc.terr_vpc.id}"
    cidr_block = "${var.pri_cidr_2}"
    availability_zone = "us-east-1c"
    tags {
        Name = "${var.env}_${var.app}_publicsub_d"
        Creator = "Terraform"
    }
}
