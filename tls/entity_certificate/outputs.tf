output certificate_pem {
  value = tls_locally_signed_cert.entity.cert_pem
}

output private_key {
  value = module.key.private_key_pem
}
