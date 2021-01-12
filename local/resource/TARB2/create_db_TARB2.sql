-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/TARB2/create_db_TARB2.sql,v 1.1 2012/04/04 09:19:28 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : create_db.sql
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
-- ----------------------------------------------------------------------------------------------

set echo on

CREATE DATABASE DARB2
   -- general section
	USER SYS IDENTIFIED BY SYS_DARB2
	USER SYSTEM IDENTIFIED BY SYSTEM_DARB2
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
		GROUP 1 ('${DBF_BASE}/redo01a.log', '${ARCH_ROOT}/oradata/DARB1/redo01b.log') SIZE 50M, 
		GROUP 2 ('${DBF_BASE}/redo02a.log', '${ARCH_ROOT}/oradata/DARB1/redo02b.log') SIZE 50M, 
		GROUP 3 ('${DBF_BASE}/redo03a.log', '${ARCH_ROOT}/oradata/DARB1/redo03b.log') SIZE 50M,
		GROUP 4 ('${DBF_BASE}/redo04a.log', '${ARCH_ROOT}/oradata/DARB1/redo04b.log') SIZE 50M
   -- tablespace section
	EXTENT MANAGEMENT LOCAL 
	DATAFILE '${DBF_BASE}/system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE 8000M 
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
