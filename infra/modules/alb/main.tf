resource "aws_security_group" "alb_sg" {
    name    = "${var.project}-lb-sg"
    description = "Security group for load balancer"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow HTTP from anywhere"
        from_port   = 3000
        to_port     = 3000 # 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_lb" "lb" {
    name = "${var.project}-lb"

    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = var.public_subnet_ids

    tags = {
        Name = "${var.project}-lb"
    }
}

resource "aws_lb_target_group" "tg" {
    name = "${var.project}-tg"
    port = 3000
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "ip"
    health_check { path = "/" }
  tags = {
    Name = "${var.project}-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}