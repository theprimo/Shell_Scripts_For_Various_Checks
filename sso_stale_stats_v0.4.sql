/*
#*******************************************************************************
#  SCRIPT               : sso_stale_stats.sql
#  FUNCTIONALITY        : To identify if the statistics associated in SSOHUB schema tables are stale or not!!
#  AUTHOR               : Venkatesh Cherukuri
#  OWNER:               : SSO AM Support
#  DATE                 : 18-04-2016
#  VERSION              : 4.0
#  Database             : SSO
#  Parameters:          : NONE
#*******************************************************************************
###
*/
set serveroutput on
set array 400
set pages 0
set wrap off
set flush off
set feed off
set feedback off
set echo off
set verify off
set term off
set head off
SET TRIMSPOOL ON
set colsep "$"
set linesize 2000
SPOOL &1

Declare
  BEGIN
  dbms_output.put_line ('The following tables have stale statistics:');
  dbms_output.put_line(chr(10));
  dbms_output.put_line(rpad('OWNER',30,' ') ||' '||rpad('TABLE NAME',40,' ')||' '||rpad('NUM_ROWS',30,' ')||' '||'LAST ANALYZED');
  dbms_output.put_line(rpad('-----------',30,' ') ||' '||rpad('-----------',40,' ') ||' '||rpad('-------------------------',30,' ')||' '||'------------------------');

  FOR r_flag IN (select owner, table_name, num_rows, last_analyzed
                  FROM sys.all_tab_statistics
                  WHERE stale_stats = 'YES'
                  AND owner NOT LIKE '%SYS%'
                  ORDER BY owner, table_name) LOOP

      dbms_output.put_line(rpad(r_flag.owner,30,' ') ||' '||rpad(r_flag.table_name,40,' ')||' '||rpad(r_flag.num_rows,30,' ') ||' '||r_flag.last_analyzed);
  END LOOP;

END;
/
spool off

