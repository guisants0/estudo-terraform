# Como boa pratica é sempre bom o arquivo principal do terraform ser chamado de main.tf



provider "aws" {                      # Provider será o seu provedor Cloud onde quera atuar com Terraform.
    version = "~> 3.0"                # versão usada no momento (checar sempre a versão mais atual).
    region = "us-east-1"              # Região onde você está trabalhando 
  
}

provider "aws" {
  alias = "us-east-2"                 # Quando precisar passar sua infraestrutura para outra região basta usar o alias.
  version = "~> 3.0"
  region = "us-east-2"

}

resource "aws_instance" "G" {         # Resource precisa ter um tipo, que no caso do nosso exemplo é uma instancia da aws. Ele tambem precisa ter um nome logo em seguida.
  count = 3                           # Count são o numero de maquinas que você gostaria de usar.
  ami = var.amis["us-east-1"]        # ami aqui é a imagem que vamos usar na nossa instanci. Encontramos ela quando vamos criar uma instacia manualmente no dashboard( Ex: Ubuntu, Debian, RedHat).
  instance_type = "t2.micro"          # instance_type é o tipo da instancia onde tambem encontramos no nosso dashboard com variados tipos de cpu e memoria.
  key_name = var.key_name               # Essa chave que deve estar vinculada no user da AWS dara acesso as maquinas. Caso não tenha as chaves crie um par de chaves no dashboar
  tags = {                            # Servem para a marcação de cada recurso usado.
    Name = "G${count.index}"          # ${count.index} para dar referencia ao numero de recursos usados.
  }

  vpc_security_group_ids = ["sg-0614333cc860543c3"]                   # vpc_security_group é para adcionar um security_group da sua escolha ou mais de um.
                           # ["${aws_security_group.acesso-ssh.id}"]  # aqui temos um exemplo onde usamos referencia para encontrar o id do security group com acesso a ssh.
}


resource "aws_instance" "G4" {
  ami = var.amis["us-east-1"] 
  instance_type = "t2.micro"
  key_name = var.key_name

  tags = {
    Name = "G4"
  }
  
  vpc_security_group_ids = ["sg-0614333cc860543c3"]
  depends_on = [
    aws_s3_bucket.G4                                                  # Aqui indica que essa instancia depende do Bucket S3 G4. Os buckets pode ter entre 3 e 63 caracteres e pode conter apenas letras minúsculas, números, pontos e hífens.
  ]
}

resource "aws_instance" "G5" {
  ami = var.amis["us-east-1"] 
  instance_type = "t2.micro"
  key_name = var.key_name

  tags = {
    Name = "G5"
  }
  
  vpc_security_group_ids = ["sg-0614333cc860543c3"]
}

resource "aws_instance" "G6" {
  provider = "aws.us-east-2"                                         # Provider para referenciar que estamos indo para outra região.
  ami = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name = var.key_name
  depends_on = [
    aws_dynamodb_table.db-us-east-2
  ]

  tags = {
    Name = "G6"
  }
  
  vpc_security_group_ids = ["${aws_security_group.acess-ssh-us-east-2.id}"]               # Criar um security group para cada região 
}

# Para fazer o deploy é preciso seguir os seguintes passos
# execute o comando terraform init para iniciar o terraform.
# execute o comando terraform plan para nos mostrar como vai ficar o ambiente 
# execute o comando terraform apply para fazer o deploy no seu provider 
# execute o comando terraform show para ver como está seu ambiente.
