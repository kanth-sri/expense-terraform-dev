module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name
  records = [
    {
      name    = "mysql"
      type    = "A"
      ttl     = 5
      records = [
        module.mysql.private_ip
      ]
    },
    {
      name    = "backend"
      type    = "A"
      ttl     = 5
      records = [
        module.backend.private_ip
      ]
    },
    {
      name    = "frontend"
      type    = "A"
      ttl     = 5
      records = [
        module.frontend.private_ip
      ]
    },
    {
      name    = ""
      type    = "A"
      ttl     = 5
      records = [
        module.frontend.public_ip
      ]
    }
  ]
}