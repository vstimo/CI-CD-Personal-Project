variable "project" {
    default = "timo-network"
}
variable "vpc_cidr" {
    description = "VPC CIDR"
    type        = string
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b"]
}
