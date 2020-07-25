#!/bin/bash

#########################################################
######   Add and remove entries from hosts file   ####### 
#########################################################

#### Functions 

add_entry()
{
	ip=$1
	hostname=$2
	hosts_path=$3
	
	if check_entry $ip $hostname $hosts_path then;
		echo "Entry for specified Hostname: $hostname already exists"
	else
		echo >> "$ip	$hostname"
		echo "Entry: \"$ip	$hostname\"  was added"
	fi
}

remove_entry()
{
	ip=$1
        hostname=$2
        hosts_path=$3

  	if check_entry $ip $hostname $hosts_path then;
		sed '/$hostname/d' $hosts_path -i
		echo "Entry: \"$ip      $hostname\"  was removed"
        else
                echo >> "Entry for the specified Hostname: $hostname does not exist"
        fi	

}

check_entry_exists()
{
	ip=$1
	hostname=$2
	hosts_path=$3
	if grep $hostname $hosts_path --quiet ;then
		return
	fi
	
	false
}


############ main #############

remove_or_add_entry=2	
ip=""
hostname=""
hosts_path="/etc/hosts"
OTHER_ARGUMENTS=()

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
	-add|-remove)	        
	if [ $arg = "-add" ]; then
		remove_or_add_entry=1
	else
		remove_or_add_entry=0
	fi
	shift # Remove -add or -remove when processing
	;;
	-ip=*)
	ip="${arg#*=}"
	shift # Remove argument name from processing
	;;
	-hostname=*)		
	hostname="${arg#*=}"
	shift # Remove argument name from processing
	;;
	*)
	OTHER_ARGUMENTS+=("$1")
	shift # Remove generic argument from processing
	;;
    esac
done

if [ $remove_or_add_entry -eq 1 ] then;
	add_entry $ip $hostname $hosts_path
elif [ $remove_or_add_entry -eq 0 ] then;
	remove_entry $ip $hostname $hosts_path
else
	echo "Please supply action: remove/add"

fi


