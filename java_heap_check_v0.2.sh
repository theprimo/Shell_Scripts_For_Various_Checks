curHrMin=`date +"%H:%M"`
MAXHEAPLIMIT=70.99

pid=`ps -ef | grep "weblogic.Server" | grep -v $curHrMin |awk -F ' ' '{print $2}' | head -1`

ec=`/products/jdk1.7/bin/jstat -gc $pid | tail -1 | awk -F ' ' '{print $5}'`
eu=`/products/jdk1.7/bin/jstat -gc $pid | tail -1 | awk -F ' ' '{print $6}'`

eUsage=$(echo "scale=6;$eu/$ec" | bc)
ePer=$(echo "scale=6;$eUsage*100" | bc)
echo "Current Eden Space (HEAP)="$ePer

if [ "$(echo $ePer '>' 99.99 | bc -l)" -eq 1 ]

    then
     echo "Load on Eden Space is" ${ePer}%
fi

pc=`/products/jdk1.7/bin/jstat -gc $pid | tail -1 | awk -F ' ' '{print $9}'`
pu=`/products/jdk1.7/bin/jstat -gc $pid | tail -1 | awk -F ' ' '{print $10}'`


pUsage=$(echo "scale=6;$pu/$pc" | bc)
PPer=$(echo "scale=6;$pUsage*100" | bc)
echo "Current PermGenSpace Usage="$PPer

#if [ "$(echo $PPer '>' 69.99 | bc -l)" -eq 1 ]
if (( $(echo "$PPer > $MAXHEAPLIMIT" |bc -l) )); 
then
     echo "Load on PermGen Space is" ${PPer}%
     echo -e "Hi All \n\n PermGen Threshold of 99.99% exceeded and the usage detected is ${PPer}%  \n\n Thanks & Regards,\n SSO AM Team"| mailx -s "Alert!! in $HOSTNAME - Interface connection status" v.a.cherukuri@accenture.com

fi
