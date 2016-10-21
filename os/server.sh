#!/bin/bash

DATE=$(date | awk '{print $1"_"$2 "_"$3"_"$4}')
file=$(cat /home/jenkins/git/testing/os/ip.txt)
count=1
#exec 3<&0
#exec 0< ${file}

if [[ ! -d /var/log/os/log  ]];then
        mkdir -p /var/log/os/log
        fi;


Automtic (){

for IP in ${file}

do

		scp  -o "StrictHostKeyChecking no" -o "PreferredAuthentications=publickey" /tmp/os/report.sh root@$IP:/tmp/
		
		if [[ $? -eq "0" ]];then

		ssh -o PasswordAuthentication=no -o StrictHostKeyChecking=no root@$IP "chmod 777 /tmp/report.sh;sh /tmp/report.sh;exit"
#		num=$(echo "$count")
#		count=$[$count +1]
		else
		exit 0
		fi;
done;

}

Automtic >> /var/log/os/log/server_report_$DATE
