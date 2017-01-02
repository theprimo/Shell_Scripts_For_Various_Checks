curHrMin=`date +"%H:%M"`
MAXGCLIMIT=99.99

pid=`ps -ef | grep "weblogic.Server" | grep -v $curHrMin |awk -F ' ' '{print $2}' | head -1`
gc_usage=`/products/jdk1.7/bin/jstat -gccause $pid | tail -1 | awk -F ' ' '{print $3}'`

#echo $pid
#echo $gc_usage
#floating arithrmatic : comparison
if (( $(echo "$gc_usage > $MAXGCLIMIT" |bc -l) )); 
then
        echo -e "Hi All,\n\n ALERT!!!\tGarbage Collection status on SK WLS Host $HOSTNAME -->NOK.\n Issue with Garbage Collection.\n Current usage - $gc_usage%.\n Please check. \n\n Thanks & Regards, \n SSO Team"| mailx -s "Alert!! in SK WLS node $HOSTNAME - Garbage Collection status" v.a.cherukuri@accenture.com
fi

