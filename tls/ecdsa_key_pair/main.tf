resource tls_private_key key {
  algorithm   = "ECDSA"
  ecdsa_curve = var.curve
}
