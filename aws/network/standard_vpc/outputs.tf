output vpc_id {
  value = aws_vpc.kubernetes.id
}

output route_table_id {
  value = aws_default_route_table.drt.id
}

output subnet_a_id {
  value = aws_subnet.ohio_a.id
}

output subnet_b_id {
  value = aws_subnet.ohio_b.id
}

output subnet_c_id {
  value = aws_subnet.ohio_c.id
}
