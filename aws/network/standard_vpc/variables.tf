variable cidr_block {}

variable vpc_name {}

variable addl_tags {
  type    = map(string)
  default = {}
}

variable subnet_tags {
  type    = map(string)
  default = {}
}

variable subnet_bits {
  type = number
  default = 3
}

variable region {}

variable domain_name {}