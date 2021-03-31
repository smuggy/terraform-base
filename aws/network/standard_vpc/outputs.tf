output vpc_id {
  value = aws_vpc.vpc.id
}

output route_table_id {
  value = aws_default_route_table.drt.id
}

output subnet_a_id {
  value = aws_subnet.az_a.id
}

output subnet_b_id {
  value = aws_subnet.az_b.id
}

output subnet_c_id {
  value = aws_subnet.az_c.id
}
