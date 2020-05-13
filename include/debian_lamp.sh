echo "Enter into the DEBIAN_LAMP INSTALLATION"
echo "Please be Patient: Installation will start now....... It may take some time :)"
#PHP7 PPA
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ondrej/php

sudo apt-get update
sudo apt-get -y install apache2 php7.0 libapache2-mod-php7.0 php7.0-mcrypt php7.0-curl php7.0-mysql php7.0-gd php7.0-cli php7.0-dev mysql-client
php7.0enmod mcrypt


sudo apt-get -y install mysql-server
echo -e "\n"
service apache2 restart && service mysql restart > /dev/null
echo -e "\n"
php -v
if [ $? -ne 0 ]; then
   echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi

echo -e "\n"
echo "Existing from Installation"
