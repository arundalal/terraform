resource "aws_nat_gateway" "TERRVPC_NGW_1" {
    allocation_id = "${aws_eip.TERRVPC_EIP_1.id}"
    subnet_id = "${aws_subnet.PublicSub_1.id}"
}
resource "aws_nat_gateway" "TERRVPC_NGW_2" {
    allocation_id = "${aws_eip.TERRVPC_EIP_2.id}"
    subnet_id = "${aws_subnet.PublicSub_2.id}"
}