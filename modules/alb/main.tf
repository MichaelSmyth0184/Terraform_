resource "aws_alb_target_group" "alb_target_group_http" {
  name                      = "${var.project}-${var.environment}-http-TG"
  port                      = 80
  protocol                  = "HTTP"
  vpc_id                    = "${var.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-http-TG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "application loadbalancer target group http"
    sqs_region              = "${var.sqs_region}"
  }
  stickiness {
    type                    = "lb_cookie"
    cookie_duration         = 1800
    enabled                 = "${var.target_group_sticky}"
  }
  health_check {
    healthy_threshold       = 3
    unhealthy_threshold     = 10
    timeout                 = 5
    interval                = 10
    path                    = "${var.target_group_path}"
    port                    = "${var.target_group_port}"
  }
}

resource "aws_alb_target_group" "alb_target_group_https" {
  name                      = "${var.project}-${var.environment}-https-TG"
  port                      = 443
  protocol                  = "HTTPS"
  vpc_id                    = "${var.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-https-TG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "application load balancer target group https"
    sqs_region                  = "${var.sqs_region}"
  }
  stickiness {
    type                    = "lb_cookie"
    cookie_duration         = 1800
    enabled                 = "${var.target_group_sticky}"
  }
  health_check {
    healthy_threshold       = 3
    unhealthy_threshold     = 10
    timeout                 = 5
    interval                = 10
    path                    = "${var.target_group_path}"
    port                    = "${var.target_group_port}"
  }
}

resource "aws_alb" "alb" {
  name                      = "${var.project}-${var.environment}-alb"
  internal                  = "${var.alb_internal}"
  idle_timeout              = "${var.alb_idle_timeout}"
  security_groups           = ["${aws_security_group.alb_sg.id}"]
  subnets                   = ["${var.subnet_ids}"]

  tags {
    Name                    = "${var.project}-${var.environment}-alb"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "application loadbalancer"
    sqs_region              = "${var.sqs_region}"
  }
}

resource "aws_alb_listener" "alb_listener_http" {
  load_balancer_arn         = "${aws_alb.alb.arn}"
  port                      = 80
  protocol                  = "HTTP"

  default_action {
  target_group_arn          = "${aws_alb_target_group.alb_target_group_http.arn}"
  type                      = "forward"
  }

  depends_on                = ["aws_alb_target_group.alb_target_group_http",]

}

resource "aws_alb_listener" "alb_listener_https" {
  load_balancer_arn         = "${aws_alb.alb.arn}"
  port                      = 443
  protocol                  = "HTTPS"
  ssl_policy                = "ELBSecurityPolicy-2015-05"
  certificate_arn           = "arn:aws:acm:eu-west-1:100474908317:certificate/7c7b6dd5-1955-4a87-9075-eb9ca979bbc1"

  default_action {
  target_group_arn          = "${aws_alb_target_group.alb_target_group_https.arn}"
  type                      = "forward"
  }

  depends_on                = ["aws_alb_target_group.alb_target_group_https",]

}

resource "aws_alb_listener_rule" "listener_rule_http" {
  depends_on                = ["aws_alb_target_group.alb_target_group_http"]
  listener_arn              = "${aws_alb_listener.alb_listener_http.arn}"
  priority                  = "${var.priority}"
  action {
    type                    = "forward"
    target_group_arn        = "${aws_alb_target_group.alb_target_group_http.id}"
  }
  condition {
    field  = "path-pattern"
    values = ["/static/*"]
  }
}

resource "aws_alb_listener_rule" "listener_rule_https" {
  depends_on                = ["aws_alb_target_group.alb_target_group_https"]
  listener_arn              = "${aws_alb_listener.alb_listener_https.arn}"
  priority                  = "${var.priority}"
  action {
    type                    = "forward"
    target_group_arn        = "${aws_alb_target_group.alb_target_group_https.id}"
  }
  condition {
    field  = "path-pattern"
    values = ["/static/*"]
  }
}

#Instance Attachment
resource "aws_alb_target_group_attachment" "alb_web_http" {
  target_group_arn          = "${aws_alb_target_group.alb_target_group_http.arn}"
  target_id                 = "${element(var.target_ids, count.index)}"
  port                      = 80
}

resource "aws_alb_target_group_attachment" "alb_web_443" {
  target_group_arn          = "${aws_alb_target_group.alb_target_group_https.arn}"
  target_id                 = "${element(var.target_ids, count.index)}"
  port                      = 443
}

