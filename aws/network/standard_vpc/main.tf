locals {
  subnets = cidrsubnets(var.cidr_block, var.subnet_bits, var.subnet_bits, var.subnet_bits)
}

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

resource aws_subnet az_a {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.subnets[0]
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = var.subnet_tags
}

resource aws_subnet az_b {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.subnets[1]
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = var.subnet_tags
}

resource aws_subnet az_c {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.subnets[2]
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = var.subnet_tags
}

resource aws_vpc_endpoint s3_endpoint {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-east-2.s3"
  security_group_ids = [aws_security_group.endpoint.id]
}

resource aws_vpc_endpoint_route_table_association s3_route {
  route_table_id  = aws_default_route_table.drt.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}

resource aws_default_security_group kube_vpc_default {
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
    cidr_blocks = ["0.0.0.0/0"]
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