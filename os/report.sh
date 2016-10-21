#!/bin/bash
#exec 3<&0
#exec 0< ${file}
#exec 0<&3

OS_INFO (){

cat << EOF
-------------------------------------------------------------------------------------------------------------------
Server : $HOSTNAME
------------------------------------------------------------------------------------------------------------------
EOF

cat << EOF

Current Users :- 

$(w)


-----------------------------------------------------------------------------------------

Filesystem Usage:-

$(df -h)

SERVER_UPTIME:-

$(uptime)

EOF

}

echo "" 

####################################################

FS_INFO (){

df -h>>/dev/null

if [ $? = "0" ];then


                        UTZ_PERCNT=$(df -h  $monitor | awk '{print $5}' | cut -d'%' -f1 | tail -n1)

                        if [[ "$UTZ_PERCNT" -gt "15" ]] && [[ "$UTZ_PERCNT" -lt "19" ]]; then


                        	THRESHOLD=" `hostname` ***/boot** partition at WARNING******"
                        else
				THRESHOLD=" `hostname` ***/boot OK** partition at WARNING******"
			fi;

			echo "${THRESHOLD}" 
else

echo "command *df -h* failure, may be NFS issue"

fi

}


OS_INFO;FS_INFO
