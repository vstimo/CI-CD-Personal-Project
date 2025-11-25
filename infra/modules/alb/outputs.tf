output "alb_arn" {
    value = aws_lb.lb.arn
}

output "alb_dns" {
    value = aws_lb.lb.dns_name
}

output "alb_sg" {
    value = aws_security_group.alb_sg.id
}

output "alb_tg" {
    value = aws_lb_target_group.tg.arn
}