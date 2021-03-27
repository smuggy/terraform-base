output private_key_pem {
  value = module.key_pair.private_key_pem
}

output public_key_ssh {
  value = aws_key_pair.utility_pair.public_key
}

output key_pair_id {
  value = aws_key_pair.utility_pair.key_pair_id
}