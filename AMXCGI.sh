#!/bin/bash

###Apache CGI script which will parses a querystring and uses logic to change the connected device or pass a user through if already connected
##SANITIZED###



saveIFS=$IFS
IFS='=&'
parm=($QUERY_STRING)
IFS=$saveIFS
lastDevice=$(head -n 1 lastDevice.txt)


declare -A array
for ((i=0; i<${#parm[@]}; i+=2))
do
    array[${parm[i]}]=${parm[i+1]}
done

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Switch Room</title>'
echo '</head>'
echo '<body>'
echo ${array[number]}
echo '<br>'
echo ${array[ip]}
echo '<br>'
echo $lastDevice
echo '<br>'
echo 'Loading'
echo '</body>'
echo '</html>'


#Check if last connected device is current selection
if [[ "$lastDevice" != ${array[ip]} ]]; then 
	 ./changeDevice.sh ${array[number]} ${array[ip]} >> /dev/null
	echo ${array[ip]} > lastDevice.txt

#Wait for reboot, print dots every second to keep status
	i="0"
	while [ $i -lt 40 ]; 
	do
		echo "."
		i=$[$i+1]
		sleep 1
		done
fi


#Redirect to panel after waiting for reboot

echo '<html>'
echo '<meta http-equiv="refresh" content="0; url=$URL"/>'
echo '</html>'
exit 0
        
