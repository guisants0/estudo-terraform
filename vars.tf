variable "amis" {
  type = map

  default = {
    "us-east-1" = "ami-08c40ec9ead489470"
    "us-east-2" = "ami-097a2df4ac947655f"
  }
}

variable "cdirs_acess_remote" {
  type = list

  default = ["179.214.126.115/32"]
}

variable "key_name" {
  type = string

  default = "Lab-AWS"
}