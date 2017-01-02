#Check Stale Statistics on SSO Databases - 10 PROD & 3 UAT DBs
LD_LIBRARY_PATH="/u01/appl/weblogic/oracle/instantclient_11_2"
export LD_LIBRARY_PATH

MAILLIST="lgi.sso.am@accenture.com"
SSO_DIR="/u01/appl/weblogic/PM_Activity_Scripts/DB_Stale_Stats/"

cd $SSO_DIR

#Check SSO PROD DBs stale stats
#DB1
DB="P1SSONL"
rm -r STATS_REPORT*.txt
FILENAME="STATS_REPORT_"$DB"_`date +%Y%m%d`.txt"

/u01/appl/weblogic/oracle/instantclient_11_2/sqlplus '<username>/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.64.248.10)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=P1SSONL))(INSTANCE_NAME=P1SSONL1))' << THEEND
@sso_stale_stats_v0.4.sql $FILENAME;

exit;
THEEND

filesize=`ls -l $FILENAME |awk -F ' ' '{print $5}'`
if [ $filesize -gt "295" ] 
then
	mutt -s "*** Stale Statistics Report on Database $DB ***" -a $FILENAME $MAILLIST < mailmsg.txt
fi

#DB2

#DB3