data "aws_ssm_parameter" "ssm" {
  name = "/${var.project}/${var.environment}/vpc_id"
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