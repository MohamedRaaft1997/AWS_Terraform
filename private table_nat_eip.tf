resource "aws_eip" "elip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    "Name" = "NatGateway"
  }
}

output "nat_gateway_ip" {
  value = aws_eip.elip.public_ip
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private Route Table"
  }
}

resource "aws_route_table_association" "private_attach" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}