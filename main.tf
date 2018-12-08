module "us-west-1" {
  source       = "./single_region"
  aws_key_path = "${var.aws_key_path}"
  aws_key_name = "${var.aws_key_name}"
  aws_region   = "us-west-1"
  amis         = "${var.amis}"

  providers = {
    aws.singleregion = "aws.us-west-1"
  }
}

module "us-west-2" {
  source       = "./single_region"
  aws_key_path = "${var.aws_key_path}"
  aws_key_name = "${var.aws_key_name}"
  aws_region   = "us-west-2"
  amis         = "${var.amis}"

  providers = {
    aws.singleregion = "aws.us-west-2"
  }
}

module "us-east-1" {
  source       = "./single_region"
  aws_key_path = "${var.aws_key_path}"
  aws_key_name = "${var.aws_key_name}"
  aws_region   = "us-east-1"
  amis         = "${var.amis}"

  providers = {
    aws.singleregion = "aws.us-east-1"
  }
}

module "us-east-2" {
  source       = "./single_region"
  aws_key_path = "${var.aws_key_path}"
  aws_key_name = "${var.aws_key_name}"
  aws_region   = "us-east-2"
  amis         = "${var.amis}"

  providers = {
    aws.singleregion = "aws.us-east-2"
  }
}
