-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/usr/sql/app_secureemail_job.sql,v 1.1 2019/02/28 02:07:53 cvsadmin Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : app_secureemail_job
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000               2014/03/05 Initial creation.
-- ----------------------------------------------------------------------------------------------

whenever sqlerror exit 1
set serveroutput on 
set verify off

define v_schema_name='&1'

declare
	u_count number := 0;
begin
	if ('&&v_schema_name' is null) then
		--dbms_output.put_line('error');
		raise_application_error(-20000, 'Error: need to specified schema name');
	else
		select count(*) into u_count from dba_users where username=upper('&&v_schema_name');
		if (u_count > 0) then
			dbms_output.put_line('schema name = &&v_schema_name');
		else
			raise_application_error(-20001, 'Error: non-exist schema name &&v_schema_name');
		end if;
	end if;
end;
/

declare
	v_prog varchar2(100) := 'EOS_APP_SECURE_EMAIL_PROG';
	v_job varchar2(100) := 'EOS_APP_SECURE_EMAIL_JOB';
	v_cnt number;
begin
	select count(1) into v_cnt from user_scheduler_jobs where upper(job_name) = v_job;
	if (v_cnt > 0) then
		dbms_output.put_line('job exists, dropped');
		dbms_scheduler.drop_job(job_name => v_job);
	end if;

	select count(1) into v_cnt from user_scheduler_programs where upper(program_name) = v_prog;
	if (v_cnt > 0) then
		dbms_output.put_line('program exists, dropped');
		dbms_scheduler.drop_program(program_name => v_prog);
	end if;

	-- create program
	dbms_scheduler.create_program
		(program_name => v_prog
		,program_type => 'PLSQL_BLOCK'		--'STORED_PROCEDURE'
		,program_action => 'begin eos_app_secure_email; end;'
		,enabled => true
		,comments => 'eos secure email program - finapp'
		);

	-- create job
	dbms_scheduler.create_job
		(job_name => v_job
		,program_name => v_prog
		,start_date => trunc(sysdate + 1)
		,repeat_interval => 'FREQ=DAILY'
		,enabled => true
		,comments => 'eos secure email job - finapp'
		);

	commit;
end;
/
