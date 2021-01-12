-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/usr/sql/grant_user_FINAPP.sql,v 1.1 2019/02/28 02:07:54 cvsadmin Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : create_user.sql
-- Author  : Haipeng Hong
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000 H Hong        2005/06/28 Initial creation.
--           001 H Hong        2008/05/01 update for release 6+.
--           002 H Hong        2012/11/18 add XMLD and XMLX for BAU1301
-- ----------------------------------------------------------------------------------------------

-- connect system/manager
set verify off

define v_user='&1'

grant FINEOS_CONNECT_ROLE, FINEOS_RESOURCE_ROLE, SELECT_CATALOG_ROLE, SELECT ANY TABLE to &v_user
/

grant select on v_$instance to &v_user
/

-- need this one for CQ8030
grant CREATE TABLE, DROP ANY TABLE to &v_user
/

grant execute on sys.dbms_lock to &v_user
/

grant execute on sys.dbms_streams to &v_user
/

grant execute on sys.dbms_streams_adm to &v_user
/