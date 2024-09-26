data "aws_ssm_parameter" "ssm" {
  name = "/${var.project}/${var.environment}/vpc_id"
}