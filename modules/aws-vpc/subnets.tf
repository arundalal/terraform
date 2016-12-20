resource "aws_subnet" "PublicSub_1" {
    vpc_id = "${aws_vpc.TERRVPC.id}"
    cidr_block = "${var.Pub_CIDR_1}"
    availability_zone = "us-east-1b"
    tags {
        Name = "BetaVPC_PublicSub_B"
    }
}

resource "aws_subnet" "PublicSub_2" {
    vpc_id = "${aws_vpc.TERRVPC.id}"
    cidr_block = "${var.Pub_CIDR_2}"
    availability_zone = "us-east-1c"
    tags {
        Name = "BetaVPC_PublicSub_C"
    }
}

resource "aws_subnet" "PrivateSub_1" {
    vpc_id = "${aws_vpc.TERRVPC.id}"
    cidr_block = "${var.Pri_CIDR_1}"
    availability_zone = "us-east-1b"
    tags {
        Name = "BetaVPC_PrivateSub_B"
    }
}

resource "aws_subnet" "PrivateSub_2" {
    vpc_id = "${aws_vpc.TERRVPC.id}"
    cidr_block = "${var.Pri_CIDR_2}"
    availability_zone = "us-east-1c"
    tags {
        Name = "BetaVPC_PrivateSub_C"
    }
}
