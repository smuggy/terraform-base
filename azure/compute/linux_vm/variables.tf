variable rg_name {
}

variable rg_location {
}

variable environment {
  description = "environment type"
  default     = "sandbox"
}

variable zone {
  description = "zone where the instance will be placed"
  type        = string
}

variable subnet {
  description = "subnet id where the instance will be placed"
  type        = string
}

variable app {
}

variable volume_size {
  default = []
  type    = list(number)
}

variable server_group {
  default = 1
  type    = number
}

variable server_number {
  default = 1
  type    = number
}

variable ssh_public_key {
}

variable instance_size {
  default = "Standard_B1s"
}

variable server_type {
  default = "srv"
}

variable export_stats {
  type    = bool
  default = true
}

variable ami_id {
  default = ""
}

variable dns_rg_name {}
