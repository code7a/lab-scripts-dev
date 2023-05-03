#aws-cli-install.sh
yum install -y zip jq
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -u awscliv2.zip
./aws/install --update
export PATH=/usr/local/bin/:$PATH
mkdir .aws >/dev/null 2>&1 || true
cat << EOF > .aws/config
[default]
EOF
cat << EOF > .aws/credentials
[default]
aws_access_key_id = $aws_key
aws_secret_access_key = $aws_secret
EOF
chmod 600 .aws/*
