variable common_name {}

variable organization {
  default = "podspace"
}

variable algorithm {
  default = "RSA"
}

variable bits {
  type    = number
  default = 2048
}

variable hours_valid {
  type    = number
  default = 10800
}