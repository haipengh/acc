-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/E16VCF/create_db_E16VCF.sql,v 1.1 2012/02/17 00:37:29 hongh Exp $
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

CREATE DATABASE E16VCF
	MAXINSTANCES 1 
	MAXLOGHISTORY 9999
	MAXLOGFILES 16
	MAXLOGMEMBERS 4 
	MAXDATAFILES 500 
	ARCHIVELOG
	FORCE LOGGING
   DATAFILE '${DBF_BASE}/system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL 
   DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE '${DBF_BASE}/temp01.dbf' 
	SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
   UNDO TABLESPACE "UNDOTBS" DATAFILE '${DBF_BASE}/undotbs01.dbf' 
	SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   LOGFILE 
	GROUP 1 ('${DBF_BASE}/redo01a.log', '${ARCH_ROOT}/oradata/E16VCF/redo01b.log') SIZE 50M, 
	GROUP 2 ('${DBF_BASE}/redo02a.log', '${ARCH_ROOT}/oradata/E16VCF/redo02b.log') SIZE 50M, 
	GROUP 3 ('${DBF_BASE}/redo03a.log', '${ARCH_ROOT}/oradata/E16VCF/redo03b.log') SIZE 50M,
	GROUP 4 ('${DBF_BASE}/redo04a.log', '${ARCH_ROOT}/oradata/E16VCF/redo04b.log') SIZE 50M
   CHARACTER SET WE8ISO8859P1
   --NATIONAL CHARACTER SET AL16UTF16 
   USER SYS IDENTIFIED BY e16sys
   USER SYSTEM IDENTIFIED BY e16sys
/

exit
