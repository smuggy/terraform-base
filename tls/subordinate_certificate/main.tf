module key {
  source = "../key_pair"

  algorithm = var.algorithm
  bits      = var.bits
}

resource tls_cert_request csr {
  key_algorithm   = var.algorithm
  private_key_pem = module.key.private_key_pem

  subject {
    common_name  = var.common_name
    country      = var.country
    organization = var.organization
    locality     = var.city
    province     = var.province
  }
}

resource tls_locally_signed_cert subordinate {
  ca_key_algorithm      = var.ca_algorithm
  ca_private_key_pem    = var.ca_private_key
  ca_cert_pem           = var.ca_certificate
  cert_request_pem      = tls_cert_request.csr.cert_request_pem
  validity_period_hours = var.hours_valid

  is_ca_certificate     = true
  set_subject_key_id    = true

  allowed_uses = ["digital_signature", "cert_signing", "crl_signing"]
}
