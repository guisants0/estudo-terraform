resource "aws_dynamodb_table" "db-us-east-2" {
  provider = "aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"                                 # Esse modo é como vai ser feita a taxa de cobrança do uso da capacidade da maquina em relação ao volume.
  hash_key       = "UserId"                                          # Atributo a ser usado como a chave de hash (partição). Também deve ser definido como um atributo
  range_key      = "GameTitle"                                       # (Opcional, força novo recurso) Atributo a ser usado como a chave de intervalo (classificação). Também deve ser definido como um atributo.

  attribute {                                                        # conjunto de definições de atributos aninhados. Necessário apenas para os atributos hash_key e range_key.
    name = "UserId"
    type = "S"                                                       # Os tipos desse atributo são: S (string), N (número), B (binário).
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  tags = {
    Name        = "db-us-east-2"
    Environment = "production"
  }
}