resource aws_route53_zone public {
  name = var.domain_name

  tags = {
    Name = var.zone_name
  }
}
