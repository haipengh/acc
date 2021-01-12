-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/KCMSE/create_db_KCMSE.sql,v 1.2 2011/08/15 22:59:10 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : create_db.sql
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
-- ----------------------------------------------------------------------------------------------

set echo on

define _ORACLE_UNQNAME='&1'
define _REDO_BASE_1='&2'
define _REDO_BASE_2='&3'
define _DBF_BASE='&4'
define _TMPF_BASE='&5'
define _TBS_UNDO='&6'
define _DBF_UNDO_PREFIX='&7'

CREATE DATABASE &_ORACLE_UNQNAME.
   -- general section
	USER SYS IDENTIFIED BY SYS_&_ORACLE_UNQNAME.
	USER SYSTEM IDENTIFIED BY SYSTEM_&_ORACLE_UNQNAME.
	CONTROLFILE REUSE
	MAXINSTANCES 32
	MAXDATAFILES 2048
	CHARACTER SET AL32UTF8	
   -- database logging section
	MAXLOGHISTORY 9999
	MAXLOGFILES 192
	MAXLOGMEMBERS 4 
	ARCHIVELOG --NOARCHIVELOG
	FORCE LOGGING
	LOGFILE 
		GROUP 1 ('&_REDO_BASE_1./redo01a.log', '&_REDO_BASE_2./redo01b.log') SIZE 50M REUSE, 
		GROUP 2 ('&_REDO_BASE_1./redo02a.log', '&_REDO_BASE_2./redo02b.log') SIZE 50M REUSE, 
		GROUP 3 ('&_REDO_BASE_1./redo03a.log', '&_REDO_BASE_2./redo03b.log') SIZE 50M REUSE,
		GROUP 4 ('&_REDO_BASE_1./redo04a.log', '&_REDO_BASE_2./redo04b.log') SIZE 50M REUSE
   -- tablespace section
	EXTENT MANAGEMENT LOCAL 
	DATAFILE '&_DBF_BASE./system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
	SYSAUX DATAFILE '&_DBF_BASE./sysaux01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
   -- default tablespace
	DEFAULT TABLESPACE USERS 
	DATAFILE '&_DBF_BASE./users01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	--EXTENT MANAGEMENT LOCAL AUTOALLOCATE
	SEGMENT SPACE MANAGEMENT AUTO
   -- temp tablespace
	SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP 
	TEMPFILE '&_TMPF_BASE./temp01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	--EXTENT MANAGEMENT LOCAL AUTOALLOCATE
   -- undo tablespace
	SMALLFILE UNDO TABLESPACE &_TBS_UNDO.
	DATAFILE '&_DBF_BASE./undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8G
/

exit

