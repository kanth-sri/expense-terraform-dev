data "aws_ssm_parameter" "ssm_public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}
data "aws_ssm_parameter" "ssm_private_subnet_ids" {
  name = "/${var.project}/${var.environment}/private_subnet_ids"
}
data "aws_ssm_parameter" "ssm_database_subnet_ids" {
  name = "/${var.project}/${var.environment}/database_subnet_ids"
}
data "aws_ssm_parameter" "ssm_mysql" {
  name = "/${var.project}/${var.environment}/mysql_sg_id"
}
data "aws_ssm_parameter" "ssm_backend" {
  name = "/${var.project}/${var.environment}/backend_sg_id"
}
data "aws_ssm_parameter" "ssm_frontend" {
  name = "/${var.project}/${var.environment}/frontend_sg_id"
}
data "aws_ssm_parameter" "ssm_bastion" {
  name = "/${var.project}/${var.environment}/bastion_sg_id"
}
data "aws_ssm_parameter" "ssm_ansible" {
  name = "/${var.project}/${var.environment}/ansible_sg_id"
}


data "aws_ami" "ami_id"{
    most_recent = true
    owners = [ "973714476881" ]

    filter {
      name = "name"
      values = ["RHEL-9-DevOps-Practice"]
    }
    filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}