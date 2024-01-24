provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Jimmy-VPC"
  }
}

resource "aws_subnet" "my_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "Jimmy-Subnet1"
  }
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "Jimmy-Subnet2"
  }
}
# Configuration for the TF State file in S3 and Dynamo DB for state lcoking -
terraform {
  backend "s3" {
    bucket        = "tf-state-for-jimmy"
    key           = "my-environment/terraform.tfstate"
    region        = "us-east-2"
    dynamodb_table = "tf-lock"  
    encrypt       = true
  }
}
