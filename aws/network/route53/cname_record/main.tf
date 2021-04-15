resource aws_route53_record internal {
  zone_id = var.zone_id
  name    = var.name
  type    = "CNAME"
  ttl     = var.ttl
  records = [var.canonical_name]
}
