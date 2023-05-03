#jenkins-install.sh
service firewalld stop
systemctl disable firewalld
yum install wget -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade -y
yum install -y java-11-openjdk
yum install -y jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins
cat /var/lib/jenkins/secrets/initialAdminPassword