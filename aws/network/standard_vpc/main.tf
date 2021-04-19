resource aws_vpc vpc {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = merge({
    Name = var.vpc_name
  }, var.addl_tags)
}

resource aws_internet_gateway igw {
  vpc_id = aws_vpc.vpc.id
}

resource aws_default_route_table drt {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = var.addl_tags
}

resource aws_subnet public_az_a {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_bits, var.base_net + 1)
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = merge({"Name": "${var.vpc_name}-public-a", "use": "public"},var.subnet_tags)
}

resource aws_subnet public_az_b {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_bits, var.base_net + 2)
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = merge({"Name": "${var.vpc_name}-public-b", "use": "public"},var.subnet_tags)
}

resource aws_subnet public_az_c {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_bits, var.base_net + 3)
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = merge({"Name": "${var.vpc_name}-public-c", "use": "public"},var.subnet_tags)
}

resource aws_subnet private_az_a {
  count = var.private_subnet ? 1 : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_bits, var.base_net + 5)
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false

  tags = merge({"Name": "${var.vpc_name}-private-a", "use": "private"},var.subnet_tags)
}

resource aws_subnet private_az_b {
  count = var.private_subnet ? 1 : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_bits, var.base_net + 6)
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false

  tags = merge({"Name": "${var.vpc_name}-private-b", "use": "private"},var.subnet_tags)
}

resource aws_subnet private_az_c {
  count = var.private_subnet ? 1 : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_bits, var.base_net + 7)
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = false

  tags = merge({"Name": "${var.vpc_name}-private-c", "use": "private"},var.subnet_tags)
}

resource aws_vpc_endpoint s3_endpoint {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-east-2.s3"
}

resource aws_vpc_endpoint_route_table_association s3_route {
  route_table_id  = aws_default_route_table.drt.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}

resource aws_default_security_group vpc_default {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["10.0.0.0/8"]
  }
}

resource aws_security_group endpoint {
  name   = "endpoint_sg"
  vpc_id = aws_vpc.vpc.id
}

resource aws_security_group_rule https {
  security_group_id = aws_security_group.endpoint.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [var.cidr_block]
}

resource aws_vpc_dhcp_options dhcp {
  domain_name         = var.domain_name
  domain_name_servers = ["AmazonProvidedDNS"]
}

resource aws_vpc_dhcp_options_association set {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
}

resource aws_route_table private_table {
  count = var.private_subnet ? 1 : 0
  vpc_id   = aws_vpc.vpc.id
  tags = {
    use = "local"
    Name = "${var.vpc_name}-private-rt"
  }
}

resource aws_route_table_association private_a {
  count = var.private_subnet ? 1 : 0

  subnet_id      = aws_subnet.private_az_a.*.id[0]
  route_table_id = aws_route_table.private_table.*.id[0]
}

resource aws_route_table_association private_b {
  count = var.private_subnet ? 1 : 0

  subnet_id      = aws_subnet.private_az_b.*.id[0]
  route_table_id = aws_route_table.private_table.*.id[0]
}
resource aws_route_table_association private_c {
  count = var.private_subnet ? 1 : 0

  subnet_id      = aws_subnet.private_az_c.*.id[0]
  route_table_id = aws_route_table.private_table.*.id[0]
}
