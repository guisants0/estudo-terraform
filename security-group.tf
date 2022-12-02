# Criação Security Group que tem varias finalidades mas principalmente de permitir acesso HTTPS para sua maquinas.

resource "aws_security_group" "acess_ssh" {
  name = "acess_ssh"
  description = "acess_ssh"

  ingress {

    from_port = 22
    to_port = 22
    protocol = "tcp"

    cidr_blocks = var.cdirs_acess_remote
  }

  tags = {
    Name = "ssh"
  }
}


resource "aws_security_group" "acess-ssh-us-east-2" {
  provider = "aws.us-east-2"                                              # O provider aqui é usado para quando queremos referenciar outro provedor por exemplo o do mais que está em outra região.
  name = "acess-ssh-us-east-2"
  description = "acess-ssh-us-east-2"

  ingress {

    from_port = 22
    to_port = 22
    protocol = "tcp"

    cidr_blocks = var.cdirs_acess_remote
  }

  tags = {
    Name = "ssh"
  }
}