whenever sqlerror continue
exec dbms_scheduler.drop_job(job_name=>'EOS_GATHER_STATS_FINSEC_JOB', force=>true);
exec dbms_scheduler.drop_job(job_name=>'EOS_GATHER_STATS_FINAPP_JOB', force=>true);
delete from strmadmin.stm_heart_beat where dbname not like (select global_name from global_name);
drop public database link FIN;
drop public database link IDP;
truncate table FINSEC.TOSEVENT;
truncate table FINSEC.TSTATEXCEPTIONSNAPSHOT;
truncate table FINSEC.TSTATPROCESS;
truncate table FINSEC.TSTATPROCESSSNAPSHOT;
truncate table FINSEC.TSTATSERVICESNAPSHOT;
truncate table FINAPP.TACCBO_DELETE;
truncate table FINAPP.taccworkitem;
alter user BURNSS account lock;
alter user GUPTAM account lock;
alter user KONSTANG account lock;
alter user TEST account lock;
alter user HOTAA account lock;
alter user FINMIG account lock;
alter user ENVDBA account lock;
alter user CVUSYS account lock;
alter user DATACOM_MONITORING account lock;
alter user DATACOM_REPORT account lock;
alter user CONFIGTEAM account lock;
alter user EDW2MIRROR account lock;
alter user IDP_RA account lock;
alter user IDP_REP account lock;
alter user NAGIOS_MONITORING account lock;
alter user RECONCILE_READONLY account lock;
alter user SQLTXADMIN account lock;
alter user SQLTXPLAIN account lock;
alter user TRCADMIN account lock;
alter user TRCANLZR account lock;
@@grant_user_FINAPP.sql FINAPP
DELETE from FINAPP.TOCROLEHOLDERLINK where I_HOLDER in (SELECT I FROM vOSUSER where userid in ( 'WPLDGM02','WPLDGM03','WPLDGM04','WPLDGM05','WPLDGM06','WPLDGM07','WPLDGM08','WPFAIL02','SVC_EOS_WPNTF_PRD_02' ) );
update FINAPP.TOLPAYMENTEVENTINTERFACE set TRANSACTIONST='Sent' where TRANSACTIONST in ('Extracted');
commit;
alter session set current_schema=FINSEC;
@@eos_sec_secure_email.sql
@@sec_secureemail_job.sql FINSEC
alter session set current_schema=FINAPP;
@@eos_app_secure_email.sql
@@app_secureemail_job.sql FINAPP
@@SF_task_broadcast_disable.sql
@@create_sql_profile_c9ncbm5fhxm9u_01.sql

