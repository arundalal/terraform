resource "aws_internet_gateway" "TERRVPC_IGW" {
    vpc_id = "${aws_vpc.TERRVPC.id}"
}