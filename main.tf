terraform {
  required_version = "~> 1.5.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.2"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

# NOTE: apply後は、この記述は不要となる
# import {
#   // インスタンスIDを指定
#   id = "i-0e61014ea453ae3c1"
#   // リソースを指定
#   to = aws_instance.sample
# }
