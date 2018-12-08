variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "amis" {
  description = "AMIs by region"

  default = {
    eu-west-2 = "ami-e1768386" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-e1768386
    us-west-1 = "ami-e1768386" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-e1768386
    us-west-2 = "ami-e1768386" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-e1768386
    us-east-1 = "ami-e1768386" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-e1768386
    us-east-2 = "ami-e1768386" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-e1768386
  }
}
