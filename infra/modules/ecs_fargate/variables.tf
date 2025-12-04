variable "project" {
  type        = string
  default     = "timo-ecs-fargate"
}

variable "aws_vpc" {
  type = string
}

variable "environment" {
  description = "Short env name (dev, tst, prd)"
  type        = string
}

# variable "aws_region" {
#   type        = string
#   default     = "us-west-2"
# }

variable "subnet_id" {
  type        = string
}

variable "alb_sg" {
    type = string
}

variable "target_group_arn" {
  description = "ALB Target Group ARN with target_type=ip (required for Fargate). Service will register tasks here."
  type        = string
}

variable "image" {
  description = "Immutable image reference from ECR passed in by CI/CD pipeline."
  type        = string
}

variable "port" {
  type        = number
  default     = 80
}

variable "cpu" {
  description = "Task CPU units (Fargate). 256 ~= 1/4 vCPU."
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Task memory (MiB) for Fargate."
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "How many copies of the task to run."
  type        = number
  default     = 2
}