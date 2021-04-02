module key {
  source = "../key_pair"

  algorithm = var.algorithm
  bits      = var.bits
}

resource tls_self_signed_cert root {
  validity_period_hours = var.hours_valid
  is_ca_certificate     = true
  set_subject_key_id    = true

  key_algorithm         = var.algorithm
  private_key_pem       = module.key.private_key_pem
  allowed_uses = ["digital_signature", "cert_signing", "crl_signing"]
  subject {
    common_name  = var.common_name
    organization = var.organization
  }
}
