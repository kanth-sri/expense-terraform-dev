#mysql instance
module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-mysql"

  instance_type          = "t3.micro"
  ami = local.ami_id
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${local.resource_name}-mysql"
    }
  )
}
#backend instance
module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-backend"

  instance_type          = "t3.micro"
  ami = local.ami_id
  vpc_security_group_ids = [local.backend_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${local.resource_name}-backend"
    }
  )
}
#frontend instance
module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-frontend"

  instance_type          = "t3.micro"
  ami = local.ami_id
  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${local.resource_name}-frontend"
    }
  )
}
#ansible instance 
module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-ansible"

  instance_type          = "t3.micro"
  ami = local.ami_id
  vpc_security_group_ids = [local.ansible_sg_id]
  subnet_id              = local.public_subnet_id
  user_data = file("expense.sh")
  tags = merge(
    var.common_tags,
    {
        Name = "${local.resource_name}-ansible"
    }
  )
}