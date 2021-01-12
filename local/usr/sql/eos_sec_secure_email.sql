-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/usr/sql/eos_sec_secure_email.sql,v 1.1 2019/02/28 02:07:53 cvsadmin Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : eos_sec_secure_email
-- Purpose :
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000               2014/03/05 Initial creation.
-- ----------------------------------------------------------------------------------------------

create or replace procedure eos_sec_secure_email as
begin
	DELETE FROM ROSPVHOLDOSLIMITLIMITS
	WHERE	C_TO = 1015
	AND 	I_TO IN 
		(SELECT t2.I
		FROM tossecuredaction t1, toslimit t2
		WHERE     t1.name = 'ACC_SENDEMAIL'
		AND T1.C = T2.C_OSSECACT_LIMITS
		AND T1.I = T2.I_OSSECACT_LIMITS);

	commit;
end;
/
