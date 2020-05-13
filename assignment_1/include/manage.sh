read_input() {
    echo "Options are stop/restart/status/exit:"
    read user_input
    clear
    if [ $user_input == 'restart'  ]  
    then  
        echo "Restarting MySQL..."
        /etc/init.d/mysql restart

        echo "Restarting Apache..."
        /etc/init.d/apache2 restart
        read_input
    elif [ $user_input == 'stop'  ]
    then 
        echo "Stopping MySQL..."
        /etc/init.d/mysql stop

        echo "Stopping Apache..."
        /etc/init.d/apache2 stop
    elif [ $user_input == 'status' ]
    then
	echo "Checking MySql-Server Status...:>"
	UP=$(/etc/init.d/mysql status | grep running | grep -v not | wc -l); 
     	if ["$UP" -ne 1]; then
		echo "MySql is Down,Start the Service"	
		start_mysql
	else
		echo "All Is Well"
	fi
	echo "Checking Apache-Server Status .... :>"
	UP=$(/etc/init.d/apache2 status | grep running | grep -v not | wc -l);
	if ["$UP" -ne 1]; then 
		echo "Apache2 is Down,Start the Service"
		start_apache
	else
		echo "All is well"
	fi
    elif  [$user_input == 'exit']; then
	    exit 1
	     
  fi
}

start_mysql() {
echo "Starting MySQL..."
/etc/init.d/mysql start
}
start_apache() {
echo "Starting Apache..."
/etc/init.d/apache2 start
}

echo "Entering into SERVICES"
start_mysql
start_apache
read_input
echo "EXIT from SERVICES"
