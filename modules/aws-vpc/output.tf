output "vpc_id" {
  value = "${aws_vpc.TERRVPC.id}"
}

output "public_subnet_ids" {
  value = [
    "${aws_subnet.PublicSub_1.id}", 
    "${aws_subnet.PublicSub_2.id}"
    ]
}

output "private_subnet_ids" {
  value = [
    "${aws_subnet.PrivateSub_1.id}", 
    "${aws_subnet.PrivateSub_2.id}"
  ]
}