-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/TESB10/create_db_TESB10.sql,v 1.1 2013/01/31 01:40:20 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : init_db.sql
-- Author  : Haipeng Hong
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000 H Hong        2005/06/28 Initial creation.
--           001 H Hong        2005/07/14 updated to conform to the new standard layout
-- ----------------------------------------------------------------------------------------------

set echo on

CREATE DATABASE TESB10
	MAXINSTANCES 2
	MAXLOGHISTORY 9999
	MAXLOGFILES 16
	MAXLOGMEMBERS 4 
	MAXDATAFILES 1024
	ARCHIVELOG
	FORCE LOGGING
   DATAFILE '${DBF_BASE}/system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL 
   SYSAUX DATAFILE '${DBF_BASE}/sysaux01.dbf'
	SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   DEFAULT TABLESPACE USERS 
	DATAFILE '${DBF_BASE}/users01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
   SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP 
	TEMPFILE '${DBF_BASE}/temp01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
   SMALLFILE UNDO TABLESPACE "UNDOTBS1" 
	DATAFILE '${DBF_BASE}/undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   LOGFILE 
	GROUP 1 ('${DBF_BASE}/redo01a.log', '${ARCH_ROOT}/oradata/TESB10/redo01b.log') SIZE 50M, 
	GROUP 2 ('${DBF_BASE}/redo02a.log', '${ARCH_ROOT}/oradata/TESB10/redo02b.log') SIZE 50M, 
	GROUP 3 ('${DBF_BASE}/redo03a.log', '${ARCH_ROOT}/oradata/TESB10/redo03b.log') SIZE 50M,
	GROUP 4 ('${DBF_BASE}/redo04a.log', '${ARCH_ROOT}/oradata/TESB10/redo04b.log') SIZE 50M
   CHARACTER SET AL32UTF8	
   --NATIONAL CHARACTER SET AL16UTF16 
   USER SYS IDENTIFIED BY SYS_TESB10
   USER SYSTEM IDENTIFIED BY SYSTEM_TESB10
/

exit
