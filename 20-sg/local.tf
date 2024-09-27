locals {
  frontend_sg_id = data.aws_ssm_parameter.ssm_frontend.value
  bastion_sg_id = data.aws_ssm_parameter.ssm_bastion.value
  backend_sg_id = data.aws_ssm_parameter.ssm_backend.value
  mysql_sg_id = data.aws_ssm_parameter.ssm_mysql.value
  ssm_value = data.aws_ssm_parameter.ssm.value
}
