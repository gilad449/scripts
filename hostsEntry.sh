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


#	if[ check_en  ]
}

remove_entry()
{
	ip=$1
        hostname=$2
        hosts_path=$3
  
}

check_entry_exists()
{
	ip=$1
	hostname=$2
	hosts_path=$3

	


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



