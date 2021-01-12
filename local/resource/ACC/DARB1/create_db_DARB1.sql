-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/DARB1/create_db_DARB1.sql,v 1.1 2010/09/15 23:37:41 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : init_db.sql
-- Author  : Haipeng Hong
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000 H Hong        2009/11/24 Initial creation for 11gR1
-- ----------------------------------------------------------------------------------------------

set echo on

CREATE DATABASE DARB1
   -- general section
	USER SYS IDENTIFIED BY SYS_DARB1
	USER SYSTEM IDENTIFIED BY SYSTEM_DARB1
	CONTROLFILE REUSE
	MAXINSTANCES 4
	MAXDATAFILES 2048
	CHARACTER SET AL32UTF8	
   -- database logging section
	MAXLOGHISTORY 9999
	MAXLOGFILES 16
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
	DATAFILE '${DBF_BASE}/system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	SYSAUX DATAFILE '${DBF_BASE}/sysaux01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   -- default tablespace
	DEFAULT TABLESPACE USERS 
	DATAFILE '${DBF_BASE}/users01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	
	SEGMENT SPACE MANAGEMENT AUTO
   -- temp tablespace
	SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP 
	TEMPFILE '${DBF_BASE}/temp01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	
   -- undo tablespace
	SMALLFILE UNDO TABLESPACE UNDOTBS1
	DATAFILE '${DBF_BASE}/undotbs01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
/

exit
