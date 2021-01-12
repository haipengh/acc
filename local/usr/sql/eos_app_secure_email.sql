-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/usr/sql/eos_app_secure_email.sql,v 1.1 2019/02/28 02:07:53 cvsadmin Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : eos_app_secure_email
-- Purpose :
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000               2014/03/05 Initial creation.
--           001               2018/04/24 update from FINEOS 
-- ----------------------------------------------------------------------------------------------

create or replace procedure eos_app_secure_email(p_email_addr in varchar2 default 'Invalid@Invalid.Invalid') as
	v_cnt number := 0;
	v_tag varchar2(100) := 'BAU1404_SECURE_EMAIL';
	v_cnt1 number := 0;
	v_tag1 varchar2(100) := 'BAU1711_SECURE_EMAIL';
	type row_trg_type is table of user_triggers%rowtype;
	v_trg_array row_trg_type ;
begin
	select * bulk collect into v_trg_array from user_triggers where table_owner='FINAPP' and table_name='TOCCONTACTMEDIUM';

	-- check previous execution
	select count(*) into v_cnt from TSCRIPTHISTORY where scriptname=v_tag;
	select count(*) into v_cnt1 from TSCRIPTHISTORY where scriptname=v_tag1;

	if (v_cnt <= 0 or v_cnt1 <= 0) then
		dbms_streams_adm.set_tag('FF');
		--execute immediate 'alter table toccontactmedium disable all triggers';
		if (v_trg_array.count>0) then
			for idx in v_trg_array.first()..v_trg_array.last() loop
				if (v_trg_array(idx).status = 'ENABLED') then
					--dbms_output.put_line(v_trg_array(idx).status);
					execute immediate 'alter trigger ' || v_trg_array(idx).trigger_name ||  ' disable';
				end if;
			end loop;
		end if;
	end if;

	UPDATE toccontactmedium t1
		SET T1.VERIFICATIONS = 7808000
		, T1.FREEFORMATADD = p_email_addr
		, T1.UPPERFREEFORM = upper(p_email_addr)
	WHERE t1.CONTACTMETHOD = 1632003
	and (T1.VERIFICATIONS != 7808000 or T1.FREEFORMATADD != p_email_addr or T1.UPPERFREEFORM != upper(p_email_addr));  

	-- added 2018/04/24
	update toccontactmedium set
		telephoneno = null
		, areacode = null
		, intcode = null
		, freeformatadd  = null 
	where contactmethod in (1632006, 1632004, 1632001, 1632002)
	and (telephoneno is not null or areacode is not null or intcode is not null or freeformatadd is not null);

	UPDATE toccontactmedium_history t1
		SET T1.VERIFICATIONS = 7808000
		, T1.FREEFORMATADD = p_email_addr
		--, T1.UPPERFREEFORM = upper(p_email_addr)
	WHERE t1.CONTACTMETHOD = 1632003
	and (T1.VERIFICATIONS != 7808000 or T1.FREEFORMATADD != p_email_addr);  

	-- added 2018/04/24
	update toccontactmedium_history t1 set
		telephoneno = null
		, areacode = null
		--, intcode = null
		, freeformatadd  = null 
	where contactmethod in (1632006, 1632004, 1632001, 1632002)
	and (telephoneno is not null or areacode is not null or freeformatadd is not null);

	commit;

	if (v_cnt <= 0 or v_cnt1 <= 0) then
		--execute immediate 'alter table toccontactmedium enable all triggers';
		if (v_trg_array.count>0) then
			for idx in v_trg_array.first()..v_trg_array.last() loop
				if (v_trg_array(idx).status = 'ENABLED') then
					--dbms_output.put_line(v_trg_array(idx).status);
					execute immediate 'alter trigger ' || v_trg_array(idx).trigger_name ||  ' enable';
				end if;
			end loop;
		end if;
	end if;

	INSERT INTO TSCRIPTHISTORY(daterun, scriptname, osusername, host) SELECT SYSDATE, v_tag, sys_context('userenv', 'os_user'), sys_context('userenv','TERMINAL') FROM dual;
	INSERT INTO TSCRIPTHISTORY(daterun, scriptname, osusername, host) SELECT SYSDATE, v_tag1, sys_context('userenv', 'os_user'), sys_context('userenv','TERMINAL') FROM dual;

	commit;

end;
/

