output vpc_id {
  value = aws_vpc.vpc.id
}

output route_table_id {
  value = aws_default_route_table.drt.id
}

output private_a_id {
  value = aws_subnet.private_az_a.id
}

output private_b_id {
  value = aws_subnet.private_az_b.id
}

output private_c_id {
  value = aws_subnet.private_az_c.id
}
