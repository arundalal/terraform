resource "aws_nat_gateway" "terrvpc_ngw_1" {
    allocation_id = "${aws_eip.terrvpc_eip_1.id}"
    subnet_id = "${aws_subnet.publicsubnet_1.id}"
}
