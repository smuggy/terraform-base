resource aws_route53_record reverse {
  zone_id = var.zone_id
  type    = "PTR"
  name    = var.ip_portion
//  join(".",
//  reverse(regex("[[:digit:]]*.[[:digit:]]*.([[:digit:]]*).([[:digit:]]*)",
//  aws_instance.server.private_ip)))
  ttl     = var.ttl
  records = [var.name]
}
