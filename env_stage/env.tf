provider "aws" {
    profile = "default"
    region = "us-east-1"
}
module "aws-vpc" { 
    source = "/home/ubuntu/workspace/terrform_infra/terraform/modules/aws-vpc"
    VPC_NAME = "${var.Ext_VPC_Name}"
    VPC_CIDR = "${var.Ext_VPC_CIDR}"
    Pub_CIDR_1 = "${var.Ext_Pub_CIDR_1}" 
    Pub_CIDR_2 = "${var.Ext_Pub_CIDR_2}"
    Pri_CIDR_1 = "${var.Ext_Pri_CIDR_1}"
    Pri_CIDR_2 = "${var.Ext_Pri_CIDR_2}"
    PubRoute = "${var.Ext_PubRoute}"
    PriRoute = "${var.Ext_PriRoute}"
}

module "aws_webapp" {
    source = "/home/ubuntu/workspace/terrform_infra/terraform/modules/aws-webapp"
    WebApp_SecGP = "${var.Ext_WebApp_SecGP}"
    Temp_vpc_id = "${module.aws-vpc.vpc_id}"
    Temp_pubsub_id = ["${module.aws-vpc.public_subnet_ids}"]
    Temp_prisub_id = ["${module.aws-vpc.private_subnet_ids}"]
    Temp_Webapp_elb = "${var.Ext_Webapp_ELB}"
    Temp_environment_name = "${var.Ext_environment_name}"
}