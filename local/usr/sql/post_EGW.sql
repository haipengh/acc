whenever sqlerror continue
exec dbms_scheduler.drop_job(job_name=>'EGW_GATHER_STATS_JOB', force=>true);
exec dbms_streams_adm.remove_streams_configuration;
delete from strmadmin.stm_heart_beat where dbname not like (select global_name from global_name);
delete from EGATEWAY_OWNER.vendor_organisation;
delete from EGATEWAY_OWNER.organisations;
commit;
exec ess_owner.ess_egateway_pkg.p_purge_audit_tables();
