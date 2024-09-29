module "mysql_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "mysql"
  common_tags = var.common_tags
}
module "backend_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "backend"
  common_tags = var.common_tags
}
module "frontend_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "frontend"
  common_tags = var.common_tags
}
module "bastion_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "bastion"
  common_tags = var.common_tags
}
module "ansible_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "ansible"
  common_tags = var.common_tags
}
#mysql sg will allow conections from insances attached to backend sg
resource "aws_security_group_rule" "mysql-backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}
#backend sg will allow conections from insances attached to frontend sg
resource "aws_security_group_rule" "backend-frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.frontend_sg.sg_id
  security_group_id = module.backend_sg.sg_id
}
#frontend sg will allow conections from public
resource "aws_security_group_rule" "frontend-public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.frontend_sg.sg_id
}
#mysql sg will allow connections from instances attached to bastion sg
resource "aws_security_group_rule" "mysql-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}
#backend sg will allow connections from instances attached to bastion sg
resource "aws_security_group_rule" "backend-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.backend_sg.sg_id
}
#frontend sg will allow connections from instances attached to bastion sg
resource "aws_security_group_rule" "frontend-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.frontend_sg.sg_id
}
resource "aws_security_group_rule" "frontend-ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =  module.ansible_sg.sg_id
  security_group_id = module.frontend_sg.sg_id
}
resource "aws_security_group_rule" "backend-ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.ansible_sg.sg_id
  security_group_id = module.backend_sg.sg_id
}
resource "aws_security_group_rule" "mysql-ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.ansible_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}
resource "aws_security_group_rule" "bastion-public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.bastion_sg.sg_id
}
resource "aws_security_group_rule" "ansible-public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.ansible_sg.sg_id
}