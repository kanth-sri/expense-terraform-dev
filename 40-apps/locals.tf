locals {
  resource_name = "${var.project}-${var.environment}"
  public_subnet_id = split(",", data.aws_ssm_parameter.ssm_public_subnet_ids.value)[0]
  private_subnet_id = split(",", data.aws_ssm_parameter.ssm_private_subnet_ids.value)[0]
  database_subnet_id = split(",", data.aws_ssm_parameter.ssm_database_subnet_ids.value)[0]
  ansible_sg_id = data.aws_ssm_parameter.ssm_ansible.value
  frontend_sg_id = data.aws_ssm_parameter.ssm_frontend.value
  bastion_sg_id = data.aws_ssm_parameter.ssm_bastion.value
  backend_sg_id = data.aws_ssm_parameter.ssm_backend.value
  mysql_sg_id = data.aws_ssm_parameter.ssm_mysql.value
  ami_id = data.aws_ami.ami_id.id
}