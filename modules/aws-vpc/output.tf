output "vpc_id" {
  value = "${aws_vpc.terr_vpc.id}"
}

output "public_subnet_ids" {
  value = [
    "${aws_subnet.publicsubnet_1.id}", 
    "${aws_subnet.publicsubnet_2.id}"
    ]
}

output "private_subnet_ids" {
  value = [
    "${aws_subnet.privatesubnet_1.id}", 
    "${aws_subnet.privatesubnet_2.id}"
  ]
}