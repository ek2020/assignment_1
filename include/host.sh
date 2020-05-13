echo "Entering into HOST.SH"
PROJECTFOLDER='demo.com'
dir="/var/www/${PROJECTFOLDER}/html/"
sudo mkdir $dir 
chmod -R 755 $dir
main="success"
admin="karthick@localhost"
sitesAvailable='/etc/apache2/sites-available/'
sitesAvailabledomain=$sitesAvailable$PROJECTFOLDER.conf 
'cp /etc/apache2/sites-available/000-default.conf  /etc/apache2/sites-available/${PROJECTFOLDER}.conf'
sudo -u www-data chmod +755 /etc/apache2/sites-available/${PROECTFOLDER}.conf
VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerAdmin $admin
    ServerName $domain
    DocumentRoot $dir
    <Directory $dir>
        Allow from all
        Require all granted   
   </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/${PROJECTFOLDER}.conf
a2dissite 000-default.conf
a2ensite ${PROJECTFOLDER}.conf
 #  
a2enmod rewrite

# restart apache
systemctl restart apache2
# install git
# sudo apt-get -y install git

# install Composer
# curl -s https://getcomposer.org/installer | php
# sudo mv composer.phar /usr/local/bin/composer

echo "EXIT from HOST"
