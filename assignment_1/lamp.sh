
#!/usr/bin/env bash 
# Apache + PHP + MySQL and so on.
# You can install Apache + PHP + MySQL in an very easy way.
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cur_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

include(){
    local include=${1}
    if [[ -s ${cur_dir}/include/${include}.sh ]];then
        . ${cur_dir}/include/${include}.sh
    else
        echo "Error: ${cur_dir}/include/${include}.sh not found, shell can not be executed."
        exit 1
    fi
}


show_info(){
    echo
    echo "+-------------------------------------------------------------------+"
    echo "| Welcome to ShinChan Automation World....  :) :)		      |"
    echo "| Auto Install LAMP(Linux + Apache + MySQL + PHP ) 		      |"
    echo "| Manage  services                                                  |"
    echo "| host php application	    				      |"
    echo "| It Contains the  BackupScript         		              |"
    echo "+-------------------------------------------------------------------+"
}
 
detect_os() { 
	linux_distro
}


linux_distro () {

	echo "DETECT SYSTEM INFORMATIOM...:)"
	if [ -f /etc/redhat-release ] ; then
	    echo DISTRIBUTION=redhat
            echo FAMILY=rh
            redhat_derivative
            redhat_release
	    include redhat_lamp 
	    include manage 
	    include host # 
	elif [ -f /etc/debian_version ] ; then
            echo DISTRIBUTION=debian
            echo FAMILY=debian
            debian_derivative 
	    include debian_lamp
	    include manage 
	    include host
	fi
} 

debian_derivative () {
    if which lsb_release 2>&1 > /dev/null ; then
        echo DERIVATIVE=`lsb_release --id --short 2> /dev/null`
        echo RELEASE=`lsb_release --release --short 2> /dev/null`
        echo CODENAME=`lsb_release --codename --short 2> /dev/null`
        return
    else
        echo DERIVATIVE=unknown
        echo RELEASE=`cat /etc/debian_version`
        echo CODENAME=unknown
        return
    fi
} 

redhat_derivative () {

    local FILE=/etc/redhat-release

    grep -i 'red.*hat.*enterprise.*linux' $FILE 2>&1 > /dev/null && { echo  DERIVATIVE=rhel; return; }
    grep -i 'red.*hat.*linux' $FILE 2>&1 > /dev/null && { echo DERIVATIVE=rh; return; }
    grep -i 'cern.*e.*linux' $FILE 2>&1 > /dev/null && { echo DERIVATIVE=cel; return; }
    grep -i 'scientific linux cern' $FILE 2>&1 > /dev/null && { echo DERIVATIVE=slc; return; }
    grep -i 'centos' $FILE 2>&1 > /dev/null && { echo DERIVATIVE=centos; return; }

    echo DERIVATIVE=unknown
} 

redhat_release () {
    echo RELEASE=`tr -d 'a-zA-Z [](){}' < /etc/redhat-release`
}
# detect_os 
show_info
linux_distro
