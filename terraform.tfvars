/*For the Key Pair:
1. Open the Amazon EC2 console
2. Under Network & Security, choose 'Key Pairs'
3. Create a new key called 'Moif_aws' and save it, place it in ~/.ssh/
 
For the Keys:
1. Open the Amazon IAM console
2. Under Users, create a new user and give it AmazonEC2FullAccess permissions
3. Then go to Security Credetials and create a new key. Add those below:
*/

/* NOTE - the above are your instructions but I thought its best to add a cleaner approach

1) Instead of creating a keypair from the UI, you may create it through running ssh-keygen to 
create a public key, and then using this terraform resource

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file("${path.cwd}/Keys/demokey.pub")}"
}


and inside the instance:

key_name = aws_key_pair.key_name

Example here: https://github.com/arehmandev/Terraform-Linux-Bootcamp/blob/master/01-instance.tf


2) Instead of issuing new keys and credentials for every user, create a Role which can be assumed with the EC2 Full access
This role can then be assumed as such from terraform:
provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}
*/

aws_access_key = "ADD_KEY_HERE"

aws_secret_key = "ADD_SECRET_HERE"

aws_key_path = "~/.ssh/Moif_aws.pem"

aws_key_name = "Moif_aws"
