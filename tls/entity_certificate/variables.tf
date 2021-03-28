variable common_name {}

variable alternate_names {
  type = list(string)
}

variable alternate_ips {
  type    = list(string)
  default = []
}

variable ca_private_key {}

variable ca_certificate {}

variable organization {
  default = "podspace"
}

variable country {
  default = "US"
}

variable province {
  default = "Illinois"
}

variable city {
  default = "Chicago"
}

variable algorithm {
  default = "RSA"
}

variable ca_algorithm {
  default = "RSA"
}

variable bits {
  type    = number
  default = 2048
}

variable hours_valid {
  type    = number
  default = 3600
}