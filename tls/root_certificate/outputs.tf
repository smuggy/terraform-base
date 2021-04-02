output certificate_pem {
  value = tls_self_signed_cert.root.cert_pem
}

output private_key {
  value = module.key.private_key_pem
}
