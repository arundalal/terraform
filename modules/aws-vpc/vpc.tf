resource "aws_vpc" "TERRVPC" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    tags{
        Name = "${var.VPC_NAME}"
    }
}
