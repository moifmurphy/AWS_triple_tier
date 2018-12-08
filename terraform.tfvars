/*For the Key Pair:
1. Open the Amazon EC2 console
2. Under Network & Security, choose 'Key Pairs'
3. Create a new key called 'Moif_aws' and save it, place it in ~/.ssh/
 
For the Keys:
1. Open the Amazon IAM console
2. Under Users, create a new user and give it AmazonEC2FullAccess permissions
3. Then go to Security Credetials and create a new key. Add those below:
*/

aws_access_key = "ADD_KEY_HERE"
aws_secret_key = "ADD_SECRET_HERE"
aws_key_path = "~/.ssh/Moif_aws.pem"
aws_key_name = "Moif_aws"
