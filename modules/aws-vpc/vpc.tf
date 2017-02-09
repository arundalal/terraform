resource "aws_vpc" "terr_vpc" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    tags{
        Name = "${var.vpc_name}"
        Creator = "Terraform"
    }
}
