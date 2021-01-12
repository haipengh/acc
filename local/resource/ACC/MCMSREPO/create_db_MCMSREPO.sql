-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/MCMSREPO/create_db_MCMSREPO.sql,v 1.1 2010/09/17 00:11:39 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : init_db.sql
-- Author  : Haipeng Hong
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000 H Hong        2005/06/28 Initial creation.
-- ----------------------------------------------------------------------------------------------

set echo on

CREATE DATABASE MCMSREPO
	MAXINSTANCES 1 
	MAXLOGHISTORY 9999
	MAXLOGFILES 16
	MAXLOGMEMBERS 4 
	MAXDATAFILES 500 
	ARCHIVELOG
	--FORCE LOGGING
   DATAFILE '${DBF_BASE}/system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
	EXTENT MANAGEMENT LOCAL 
   DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE '${DBF_BASE}/temp01.dbf' 
	SIZE 500M REUSE AUTOEXTEND ON NEXT 10M MAXSIZE 1000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
   UNDO TABLESPACE "UNDOTBS1" DATAFILE '${DBF_BASE}/undotbs01.dbf' 
	SIZE 200M REUSE AUTOEXTEND ON NEXT 5120K MAXSIZE 1000M 
   LOGFILE 
	GROUP 1 ('${DBF_BASE}/redo01a.log', '${ARCH_ROOT}/oradata/MCMSREPO/redo01b.log') SIZE 10M, 
	GROUP 2 ('${DBF_BASE}/redo02a.log', '${ARCH_ROOT}/oradata/MCMSREPO/redo02b.log') SIZE 10M, 
	GROUP 3 ('${DBF_BASE}/redo03a.log', '${ARCH_ROOT}/oradata/MCMSREPO/redo03b.log') SIZE 10M,
	GROUP 4 ('${DBF_BASE}/redo04a.log', '${ARCH_ROOT}/oradata/MCMSREPO/redo04b.log') SIZE 10M
   CHARACTER SET WE8ISO8859P1 
   --NATIONAL CHARACTER SET AL16UTF16 
   USER SYS IDENTIFIED BY SYS_MCMSREPO
   USER SYSTEM IDENTIFIED BY SYSTEM_MCMSREPO
/

exit

