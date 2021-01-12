-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/TWCMEXTR/create_db_TWCMEXTR.sql,v 1.1 2010/03/02 00:20:33 hongh Exp $
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

CREATE DATABASE TWCMEXTR
   -- general section
	USER SYS IDENTIFIED BY SYS_TWCMEXTR
	USER SYSTEM IDENTIFIED BY SYSTEM_TWCMEXTR
	CONTROLFILE REUSE
	MAXINSTANCES 2
	MAXDATAFILES 1024
	CHARACTER SET AL32UTF8
	--NATIONAL CHARACTER SET AL16UTF16 
	--SET DEFAULT [SMALLFILE | BIGFILE] TABLESPACE
	--SET TIME_ZONE = [ time_zone_region | '+12:00' ] --check V$TIMEZONE_NAMES for region name
   -- database logging section
	MAXLOGHISTORY 9999
	MAXLOGFILES 16
	MAXLOGMEMBERS 4 
	ARCHIVELOG
	FORCE LOGGING
	LOGFILE 
		GROUP 1 ('${DBF_BASE}/redo01a.log', '${ARCH_ROOT}/oradata/TWCMEXTR/redo01b.log') SIZE 50M, 
		GROUP 2 ('${DBF_BASE}/redo02a.log', '${ARCH_ROOT}/oradata/TWCMEXTR/redo02b.log') SIZE 50M, 
		GROUP 3 ('${DBF_BASE}/redo03a.log', '${ARCH_ROOT}/oradata/TWCMEXTR/redo03b.log') SIZE 50M,
		GROUP 4 ('${DBF_BASE}/redo04a.log', '${ARCH_ROOT}/oradata/TWCMEXTR/redo04b.log') SIZE 50M
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
	TEMPFILE '${DBF_BASE}/temp01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	--EXTENT MANAGEMENT LOCAL AUTOALLOCATE
   -- undo tablespace
	SMALLFILE UNDO TABLESPACE "UNDOTBS1" 
	DATAFILE '${DBF_BASE}/undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
/

exit
