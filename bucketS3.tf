# Criação de bucket S3


resource "aws_s3_bucket" "G4" {

  bucket = "bucket-lab-g4"                        # Nome do bucket.
  acl = "private"                                 # Permissonamento do Bucket se é privado ou publico.
  
  tags ={
    Name = "bucket-lab-g4"
  }
}