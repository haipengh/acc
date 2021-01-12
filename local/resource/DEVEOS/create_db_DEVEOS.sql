-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/DEVEOS/create_db_DEVEOS.sql,v 1.2 2018/05/02 04:35:24 cvsadmin Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : create_db.sql
-- usage   : create_db.sql DBNAME ${REDO_BASE_1} ${REDO_BASE_2} ${DBF_BASE} ${TMPF_BASE} UNDOTBS1 undotbs1_ DEFTBS deftbs TEMP temp ${DBF_ROOT} USERS users
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
-- ----------------------------------------------------------------------------------------------

set echo on
whenever sqlerror exit 1

define _ORACLE_UNQNAME='&1'
define _REDO_BASE_1='&2'
define _REDO_BASE_2='&3'
define _DBF_BASE='&4'
define _TMPF_BASE='&5'
define _TBS_UNDO='&6'
define _DBF_UNDO_PREFIX='&7'
define _TBS_DEFAULT='&8'
define _TBS_DEFAULT_PREFIX='&9'
define _TBS_TEMP='&10'
define _TBS_TEMP_PREFIX='&11'
define _DBF_ROOT='&12'
define _SEED_TBS_USER='&13'
define _SEED_TBS_USER_PREFIX='&14'

CREATE DATABASE &_ORACLE_UNQNAME.
   -- general section
	USER SYS IDENTIFIED BY SYS_&_ORACLE_UNQNAME.			
	USER SYSTEM IDENTIFIED BY SYSTEM_&_ORACLE_UNQNAME.		
	CONTROLFILE REUSE
	MAXINSTANCES 32
	MAXDATAFILES 2048
	CHARACTER SET AL32UTF8	
	--NATIONAL CHARACTER SET AL16UTF16 
	--SET DEFAULT [SMALLFILE | BIGFILE] TABLESPACE
	--SET TIME_ZONE = [ time_zone_region | '+12:00' ] 
   -- database logging section
	MAXLOGHISTORY 9999
	MAXLOGFILES 192
	MAXLOGMEMBERS 4 
	ARCHIVELOG 
	FORCE LOGGING
	LOGFILE 
		GROUP 1 ('&_REDO_BASE_1./redo1_1.log', '&_REDO_BASE_2./redo1_2.log') SIZE 150M REUSE, 
		GROUP 2 ('&_REDO_BASE_1./redo2_1.log', '&_REDO_BASE_2./redo2_2.log') SIZE 150M REUSE, 
		GROUP 3 ('&_REDO_BASE_1./redo3_1.log', '&_REDO_BASE_2./redo3_2.log') SIZE 150M REUSE,
		GROUP 4 ('&_REDO_BASE_1./redo4_1.log', '&_REDO_BASE_2./redo4_2.log') SIZE 150M REUSE
   -- tablespace section
	EXTENT MANAGEMENT LOCAL 
	DATAFILE '&_DBF_BASE./system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
	SYSAUX DATAFILE '&_DBF_BASE./sysaux01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
   -- default tablespace
	DEFAULT TABLESPACE &_TBS_DEFAULT.
	DATAFILE '&_DBF_BASE./&_TBS_DEFAULT_PREFIX.01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	
	SEGMENT SPACE MANAGEMENT AUTO
   -- temp tablespace
	SMALLFILE DEFAULT TEMPORARY TABLESPACE &_TBS_TEMP.
	TEMPFILE '&_TMPF_BASE./&_TBS_TEMP_PREFIX.01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	
   -- undo tablespace
	SMALLFILE UNDO TABLESPACE &_TBS_UNDO.
	DATAFILE '&_DBF_BASE./&_DBF_UNDO_PREFIX.01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
   -- CDB section
	ENABLE PLUGGABLE DATABASE
	SEED
	FILE_NAME_CONVERT = ('&_DBF_BASE./', '&_DBF_ROOT./&_ORACLE_UNQNAME./pdbseed/', '&_TMPF_BASE./', '&_DBF_ROOT./&_ORACLE_UNQNAME./pdbseed/')
	SYSTEM DATAFILES SIZE 100M AUTOEXTEND ON NEXT 100M MAXSIZE 8G
	SYSAUX DATAFILES SIZE 100M AUTOEXTEND ON NEXT 100M MAXSIZE 8G
   -- USER_DATA for CDB or non-CDB			
	USER_DATA TABLESPACE &_SEED_TBS_USER. 				
	DATAFILE '&_DBF_ROOT./&_ORACLE_UNQNAME./pdbseed/&_SEED_TBS_USER_PREFIX.01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
/

--exit
