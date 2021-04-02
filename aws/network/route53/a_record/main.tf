resource aws_route53_record internal {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"
  ttl     = var.ttl
  records = var.records
}
