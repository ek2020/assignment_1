
sudo yum install nano curl wget bind-utils telnet

# Will automatically update

sudo yum -y update

# Will automatically install Apache/HTTPD


sudo yum install httpd mod_ssl openssl mariadb-server mariadb php php-mysql php-gd php-mbstring


# Enable Services to have them load at startup
sudo systemctl enable httpd.service
sudo systemctl enable mariadb.service

# Open Firewall for HTTP and HTTPS
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload 
