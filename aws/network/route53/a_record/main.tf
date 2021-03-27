resource aws_route53_record consul_internal {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"
  ttl     = var.ttl
  records = var.records
}
