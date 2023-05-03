#aws-cli-install.sh
yum install -y zip jq
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
export PATH=/usr/local/bin/:$PATH
mkdir .aws
echo "aws_access_key_id = $aws_key
aws_secret_access_key = $aws_secret" > .aws/config
