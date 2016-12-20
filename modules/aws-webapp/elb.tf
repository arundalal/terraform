# Create a new load balancer
resource "aws_elb" "TERRAVPC_Webapp_ELB" {
  name = "${var.Temp_Webapp_elb}"
  subnets = ["${var.Temp_pubsub_id[0]}", "${var.Temp_pubsub_id[1]}"]
  security_groups = ["${aws_security_group.TERRVPC_WebApp_SG.id}"]
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

  instances = ["${aws_instance.web.*.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.Temp_Webapp_elb}"
  }
}
