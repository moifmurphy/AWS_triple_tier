# AWS Environment specific variables
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "London AWS Region"
    default = "eu-west-2"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        eu-west-2 = "ami-e1768386" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-e1768386
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}
