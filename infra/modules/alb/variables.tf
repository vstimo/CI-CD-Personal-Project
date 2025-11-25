variable "project" {
  default = "timo-project-lb"
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "public_subnet_ids" {
    type = list(string)
}