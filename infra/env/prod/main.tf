module "network" {
  source     = "../../modules/network"
}

module "alb" {
  project = "timo-prod-lb"
  source        = "../../modules/alb"
  vpc_id        = module.network.vpc_id
  public_subnet_ids    = module.network.public_subnet_ids
}

module "ecs_fargate" {
  source            = "../../modules/ecs_fargate"
  aws_vpc           = module.network.vpc_id
  environment = "prod"
  subnet_id = module.network.public_subnet_ids[0]
  alb_sg = module.alb.alb_sg
  target_group_arn = module.alb.alb_tg
  image = var.image
  desired_count = 2
}