-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/MIGREP1B/create_db_MIGREP1B.sql,v 1.1 2010/09/17 00:17:56 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : init_db.sql
-- Author  : Haipeng Hong
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000 H Hong        2006/06/27 Initial creation.
-- ----------------------------------------------------------------------------------------------

set echo on

CREATE DATABASE MIGREP1B
	MAXINSTANCES 1 
	MAXDATAFILES 500 
	MAXLOGHISTORY 9999
	MAXLOGFILES 16
	MAXLOGMEMBERS 4 
	NOARCHIVELOG
	--FORCE LOGGING
   DATAFILE '${DBF_BASE}/system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL 
   SYSAUX 
	DATAFILE '${DBF_BASE}/sysaux01.dbf'
	SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   DEFAULT TABLESPACE USERS 
	DATAFILE '${DBF_BASE}/users01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
   DEFAULT TEMPORARY TABLESPACE TEMP 
	TEMPFILE '${DBF_BASE}/temp01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
   UNDO TABLESPACE UNDOTBS1
	DATAFILE '${DBF_BASE}/undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   LOGFILE 
	GROUP 1 ('${DBF_BASE}/redo01a.log', '${ARCH_ROOT}/oradata/MIGREP1B/redo01b.log') SIZE 50M, 
	GROUP 2 ('${DBF_BASE}/redo02a.log', '${ARCH_ROOT}/oradata/MIGREP1B/redo02b.log') SIZE 50M, 
	GROUP 3 ('${DBF_BASE}/redo03a.log', '${ARCH_ROOT}/oradata/MIGREP1B/redo03b.log') SIZE 50M,
	GROUP 4 ('${DBF_BASE}/redo04a.log', '${ARCH_ROOT}/oradata/MIGREP1B/redo04b.log') SIZE 50M
   CHARACTER SET WE8ISO8859P1 
   --NATIONAL CHARACTER SET AL16UTF16 
   USER SYS IDENTIFIED BY SYS_MIGREP1B
   USER SYSTEM IDENTIFIED BY SYSTEM_MIGREP1B
/

exit

