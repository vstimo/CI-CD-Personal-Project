resource "aws_ecs_cluster" "cluster"{
    name = "${var.project}-${var.environment}"
    tags = {
        Name = "${var.project}-${var.environment}"
    }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.project}-${var.environment}"
  requires_compatibilities = ["FARGATE"]   # serverless containers
  network_mode             = "awsvpc"      # required by Fargate
  cpu                      = var.cpu
  memory                   = var.memory

  # The container list; we keep it to ONE container to start.
  container_definitions = jsonencode([
    {
      name  = var.project,
      image = var.image,
      portMappings = [
        { containerPort = var.port }
      ]
    }
  ])
}


resource "aws_security_group" "task_sg" {
  name        = "${var.project}-${var.environment}-task-sg"
  description = "Allow ALB to reach task on app_port; allow egress."
  vpc_id      = var.aws_vpc

  ingress {
    description     = "From ALB only"
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = [var.alb_sg]
  }

  egress {
    description = "Internet egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# ECS Service: keeps N tasks running and registers to the ALB TG
# -----------------------------
resource "aws_ecs_service" "ecs" {
  name            = "${var.project}-${var.environment}"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  enable_execute_command = false
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.project
    container_port   = var.port
  }

  network_configuration {
    subnets         = [var.subnet_id]
    security_groups = [aws_security_group.task_sg.id]
    assign_public_ip = true
  }

  # Safe rolling updates (defaults are fine to start)
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
}