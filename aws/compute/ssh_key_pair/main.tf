module key_pair {
  source = "../../../tls/key_pair"
}

resource aws_key_pair utility_pair {
  key_name   = var.key_name
  public_key = module.key_pair.public_key_ssh
}
