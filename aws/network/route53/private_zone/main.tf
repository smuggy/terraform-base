resource aws_route53_zone internal {
  name = var.domain_name

  dynamic vpc {
    for_each = var.vpc_ids
    content {
      vpc_id = vpc.value
    }
  }

  tags = {
    Name = var.zone_name
    use  = "private"
    type = var.zone_type
  }
}
