variable "project" {
  default = "timo-project-ec2"
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "public_subnet_id" {
    type = string
    default = ""
}

variable "lb_sg" {
    type = string
    default = ""
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}