terraform {
  backend "s3" {
    bucket = "enoch-folorunsho"
    key    = "path/to/your/statefile.tfstate"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.51.0"
    }
  }
}

provider "aws" {
}
