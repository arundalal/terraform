# Create a new load balancer
resource "aws_elb" "terravpc_webapp_elb" {
  name = "${var.env}-${var.app}-elb"
  subnets = ["${var.publicsub_id[0]}", "${var.publicsub_id[1]}"]
  security_groups = ["${aws_security_group.terrvpc_webapp_sg.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:80"
    interval = 30
  }

  instances = ["${aws_instance.terr_web.*.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400
  tags {
    Name = "${var.env}_${var.app}_elb"
    Creator = "Terraform"
  }
}
