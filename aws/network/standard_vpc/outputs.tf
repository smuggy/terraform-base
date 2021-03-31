output vpc_id {
  value = aws_vpc.vpc.id
}

output route_table_id {
  value = aws_default_route_table.drt.id
}

output public_a_id {
  value = aws_subnet.public_az_a.id
}

output public_b_id {
  value = aws_subnet.public_az_b.id
}

output public_c_id {
  value = aws_subnet.public_az_c.id
}
