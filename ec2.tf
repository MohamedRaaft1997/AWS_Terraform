data "aws_ami" "linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}



resource "aws_instance" "web_ec2" {
  ami                         = data.aws_ami.linux_ami.id
  instance_type               = "t2.micro"
  key_name                    = var.key
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "MR"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > puplic_ip.txt "
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = data.aws_ami.linux_ami.id
  instance_type          = "t2.micro"
  key_name               = var.key
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "application"
  }
}
