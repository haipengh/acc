whenever sqlerror continue
exec dbms_streams_adm.remove_streams_configuration;
create or replace view strmadmin.stm_heart_beat as select * from strmadmin.EOS_HEARTBEAT union all select * from strmadmin.FMIS_HEARTBEAT;
truncate table strmadmin.EOS_HEARTBEAT;
truncate table strmadmin.FMIS_HEARTBEAT;
alter user BODLIYA account lock;
alter user DICKEYC account lock;
alter user KONSTANG account lock;
alter user MAKOIKE account lock;
alter user NARAYALO account lock;
alter user TAYLORSH account lock;
alter user CVUSYS account lock;
alter user DATACOM_MONITORING account lock;
alter user RECONCILE_READONLY account lock;
alter user RECON_SC1 account lock;
