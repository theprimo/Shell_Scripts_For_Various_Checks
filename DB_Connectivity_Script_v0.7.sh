#Test SSO 10 PROD and 3 UAT DB Instances 
LD_LIBRARY_PATH="/u01/appl/weblogic/oracle/instantclient_11_2"
export LD_LIBRARY_PATH
APP="MyUPC"
DOMAIN="SSO"
MAILLIST="lgi.sso.am@accenture.com"

#Test connectivity for PROD Databases
#NL
Node="P1SSONL DB"
`/u01/appl/weblogic/oracle/instantclient_11_2/sqlplus '<username>/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.64.248.10)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=P1SSONL))(INSTANCE_NAME=P1SSONL1))' <<ENDSQL > /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic1.log`

`/u01/appl/weblogic/oracle/instantclient_11_2/sqlplus '<username>/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.64.248.11)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=P1SSONL))(INSTANCE_NAME=P1SSONL2))' <<ENDSQL > /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic2.log`

if grep -q "ERROR" /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic1.log ; then
		rm temp.txt
        echo -e $"Hi All,\n\nPlease check the DB connectivity status for $Node Instance 1.\n\nRegards, \nSSO - IDC \n\n***Error Description***" > temp.txt
		cat /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic1.log >> temp.txt
		echo -e $"\n\n*********\n" >>temp.txt
		cat temp.txt | mailx -s "CRITICAL ALERT : $APP $DOMAIN $Node Exalogic issue" $MAILLIST
fi
if grep -q "ERROR" /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic2.log ; then
		rm temp.txt
        echo -e $"Hi All,\n\nPlease check the DB connectivity status for $Node Instance 2.\n\nRegards, \nSSO - IDC \n\n***Error Description***" > temp.txt
		cat /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic2.log >> temp.txt
		echo -e $"\n\n*********\n" >>temp.txt
		cat temp.txt | mailx -s "CRITICAL ALERT : $APP $DOMAIN $Node Exalogic issue" $MAILLIST
fi

#PL
Node="P1SSOPL DB"

`/u01/appl/weblogic/oracle/instantclient_11_2/sqlplus '<username>/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.64.248.10)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=P1SSOPL))(INSTANCE_NAME=P1SSOPL1))' <<ENDSQL > /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic1.log`

`/u01/appl/weblogic/oracle/instantclient_11_2/sqlplus '<username>/<password>@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.64.248.11)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=P1SSOPL))(INSTANCE_NAME=P1SSOPL2))' <<ENDSQL > /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic2.log`

if grep -q "ERROR" /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic1.log ; then
		rm temp.txt
        echo -e $"Hi All,\n\nPlease check the DB connectivity status for $Node Instance 1.\n\nRegards, \nSSO - IDC \n\n***Error Description***" > temp.txt
		cat /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic1.log >> temp.txt
		echo -e $"\n\n*********\n" >>temp.txt
		cat temp.txt | mailx -s "CRITICAL ALERT : $APP $DOMAIN $Node Exalogic issue" $MAILLIST
fi
if grep -q "ERROR" /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic2.log ; then
		rm temp.txt
        echo -e $"Hi All,\n\nPlease check the DB connectivity status for $Node Instance 2.\n\nRegards, \nSSO - IDC \n\n***Error Description***" > temp.txt
		cat /u01/appl/weblogic/PM_Activity_Scripts/DB_Connectivity/exalogic2.log >> temp.txt
		echo -e $"\n\n*********\n" >>temp.txt
		cat temp.txt | mailx -s "CRITICAL ALERT : $APP $DOMAIN $Node Exalogic issue" $MAILLIST
fi

