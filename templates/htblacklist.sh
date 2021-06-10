#!/bin/bash
####################################################################################################
#Title           :hotmail_block_detect.sh
#Description     :This script will check if our MTA IPs are blocked and outputs blocked MTA server 
#		  host name with blocked messages count in the whole day or last line defined.
#Author		 :Mahmoud ElRamly
#Email		 :mahmoud.elramly@exa.com.sa
#Date            :24-12-2018
#Version         :1.0    
#Usage		 :hotmail_block_detect.sh
#Notes           :File /var/log/zimbra.log must exist , Adjust last lines to be checked as desired.
#		  comment result and uncomment the other to change method. 
####################################################################################################
#Default method current day
result=`grep "$(date +"%b %_d")" /var/log/zimbra.log | grep S3140 | sed -n 's/postfix.*//p' | awk '{print $4}' | sort | uniq -c | sort -nr` #check whole day
#Alternative method last lines <on Dec 6 2018 there was 1906026 lines~22 line/sec ~ 6618 lines/5min>
lines=10000
#result=`tail -n$lines  /var/log/zimbra.log | grep S3140 | sed -n 's/postfix.*//p' | awk '{print $4}' | sort | uniq -c | sort -nr`  #check only last lines

if ((${#result} > 2))
then
	echo "Folowing MTA IPs are blocked from hotmail:"
	echo "$result"
	exit 2
else
	echo OK
	exit 0
fi
