provider "aws" {
    profile = "default"
    region = "${var.region}"
}

module "aws-vpc" { 
    source = "../modules/aws-vpc"
    vpc_name = "${var.env}_vpc"
    env = "${var.env}"
    app = "${var.app_name}" 
    vpc_cidr = "${var.env_vpc_cidr}"
    pub_cidr_1 = "${var.env_pub_cidr_1}" 
    pub_cidr_2 = "${var.env_pub_cidr_2}"
    pri_cidr_1 = "${var.env_pri_cidr_1}"
    pri_cidr_2 = "${var.env_pri_cidr_2}"
    
}

module aws-rds {
    source = "../modules/aws-rds"
    env = "${var.env}"
    prisub_id = ["${module.aws-vpc.private_subnet_ids}"]
    dbname = "${var.env}"
    vpc_id = "${module.aws-vpc.vpc_id}"
}
module "aws_webapp" {
    source = "../modules/aws-webapp"
    env = "${var.env}"
    app = "${var.app_name}"
    vpc_id = "${module.aws-vpc.vpc_id}"
    publicsub_id = ["${module.aws-vpc.public_subnet_ids}"]
    privatesub_id = ["${module.aws-vpc.private_subnet_ids}"]
}