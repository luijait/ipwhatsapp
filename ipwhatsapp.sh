

#!/bin/sh

filter=` tshark -i eth0 -T fields -f "udp" -e ip.dst -Y "ip.dst!=192.168.0.0/16 and ip.dst!=10.0.0.0/8 and ip.dst!=172.16.0.0/12" -c 100 |sort -u |xargs|sed "s/ / and ip.dst!=/g" |sed "s/^/ip.dst!=/g"`

echo "presiona enter para robarle la ip a krypton"

read line

tshark -i eth0 -l -T fields -f "udp" -e ip.dst -Y "$filter" -Y "ip.dst!=192.168.0.0/16 and ip.dst!=10.0.0.0/8 and ip.dst!=172.16.0.0/12" | while read line
do

sudo whois $line > /home/luijait/hola123

filter=`cat /home/luijait/hola123 |xargs| egrep -iv "facebook|google"|wc -l`

if [ "$filter" -gt 0 ] ; then
targetinfo=`cat /home/luijait/hola123| egrep -iw "OrgName:|NetName:|Country:"`
echo $line --- $targetinfo
fi
done
