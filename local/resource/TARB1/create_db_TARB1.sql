-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/TARB1/create_db_TARB1.sql,v 1.1 2011/02/02 23:22:23 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : create_db.sql
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
-- ----------------------------------------------------------------------------------------------

set echo on

CREATE DATABASE TARB1
   -- general section
	USER SYS IDENTIFIED BY SYS_TARB1
	USER SYSTEM IDENTIFIED BY SYSTEM_TARB1
	CONTROLFILE REUSE
	MAXINSTANCES 32
	MAXDATAFILES 2048
	CHARACTER SET AL32UTF8	
   -- database logging section
	MAXLOGHISTORY 9999
	MAXLOGFILES 192
	MAXLOGMEMBERS 4 
	ARCHIVELOG 
	FORCE LOGGING
	LOGFILE 
		GROUP 1 ('${REDO_BASE_1}/redo01a.log', '${REDO_BASE_2}/redo01b.log') SIZE 50M, 
		GROUP 2 ('${REDO_BASE_1}/redo02a.log', '${REDO_BASE_2}/redo02b.log') SIZE 50M, 
		GROUP 3 ('${REDO_BASE_1}/redo03a.log', '${REDO_BASE_2}/redo03b.log') SIZE 50M,
		GROUP 4 ('${REDO_BASE_1}/redo04a.log', '${REDO_BASE_2}/redo04b.log') SIZE 50M
   -- tablespace section
	EXTENT MANAGEMENT LOCAL 
	DATAFILE '${DBF_BASE}/system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
	SYSAUX DATAFILE '${DBF_BASE}/sysaux01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   -- default tablespace
	DEFAULT TABLESPACE USERS 
	DATAFILE '${DBF_BASE}/users01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	--EXTENT MANAGEMENT LOCAL AUTOALLOCATE
	SEGMENT SPACE MANAGEMENT AUTO
   -- temp tablespace
	SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP 
	TEMPFILE '${TMPF_BASE}/temp01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	--EXTENT MANAGEMENT LOCAL AUTOALLOCATE
   -- undo tablespace
	SMALLFILE UNDO TABLESPACE "UNDOTBS1" 
	DATAFILE '${DBF_BASE}/undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
/

exit
