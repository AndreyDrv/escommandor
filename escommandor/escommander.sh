#!/bin/bash
. ./functions.lib

#ElasticSearch basic commander
#url: https://github.com/andreydrv/escommander
#author: Glushkov Andrey, andrey@glushkov.net

#USE '-m' first! 
#ACTIONs:
# 1.start - start elastic service
# 2.stop - stop service
# 3.deploy - deploy index
# 4.clear - remove data folder and make backup "data_less_yyyy-MM-dd"

while getopts "m:tn:a:" opt; do
  case $opt in
#env mode
    m)
	set_mode $OPTARG
      ;;
#display test message
    t)
	test_function
      ;;
#number of instances
    n)
	NUMOFINST=$OPTARG
	echo "starting $NUMOFINST instances..."
	start_instances
      ;;
#action
    a) 
	ACTION=$OPTARG
	echo "$ACTION action initiated..."      
	$ACTION
      ;;
    \?)
	echo "!unknown flag"
	exit 1
      ;;
     :)
	echo "!use the force (params)"	
     ;;
  esac
done
