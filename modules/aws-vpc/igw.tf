resource "aws_internet_gateway" "terrvpc_igw" {
    vpc_id = "${aws_vpc.terr_vpc.id}"
}