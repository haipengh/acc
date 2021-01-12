-- ************************************************************************************************************************
-- HR 9.2 Reconfigure Script for UAT - to be run after UAT database (E55HCM) is refreshed (cloned) from another database
-- change history:
--    o) update 01/11/2015 after H&S release
-- ************************************************************************************************************************

--
-- BEFORE STARTING:
--
-- 1) In Process Scheduler section below...
-- Change PHCM to be the source database for the refresh (if it is not PHCM) before running the script
--
-- 2) In URL section below update hrisftp <password>
--

alter session set current_schema=sysadm;

-- *********
-- PSDBOWNER
-- *********

delete from psdbowner
/

insert into psdbowner values((select name from v$database), 'SYSADM')
/

-- *********
-- PSOPTIONS
-- *********
 
UPDATE PSOPTIONS 
SET GUID = ' ', 
SYSTEMTYPE='RAT', SHORTNAME=(select name from v$database), LONGNAME=(select name from v$database)
/


-- *****************************************************************************************
-- Email reset - blank out email addresses for UAT except for default workflow administrator
-- *****************************************************************************************
 
delete from psuseremail 
where oprid not in (select ROLEUSER from PS_WF_SYS_DEFAULTS)
/
 
update psoprdefn
set emailid = ' '
where oprid not in (select ROLEUSER from PS_WF_SYS_DEFAULTS)
/
 
update PS_ROLEXLATOPR
set emailid = ' '
where roleuser not in (select ROLEUSER from PS_WF_SYS_DEFAULTS)
/
 
UPDATE PS_EMAIL_ADDRESSES E
SET E.PREF_EMAIL_FLAG = 'N',
email_addr    = ' '
/

-- 01/11/2015 Updated to Include the scrambling of External Applicant Email Ids

UPDATE PS_HRS_APP_EMAIL 
  set EMAIL_ADDR = 'peoplesoft_applicant@hrisrat.ds.acc.co.nz'      -- Change UAT to DEV for E53HCM and SIT for E54HCM 
where EMAIL_ADDR <> ' ';
/

-- *****************
-- Process Scheduler - only PSUNX in UAT (Prod has PSUNX1 and PSUNX2)
-- *****************

update psprcsrqst
set DBNAME = (select name from v$database)
/
 
-- Change PHCM to be the source database for the refresh if it's not PHCM before running the next update SQL
update PSPRCSPARMS
set PARMLIST = REPLACE(PARMLIST, 'PHCM', (select name from v$database)), 
ORIGPARMLIST = REPLACE(ORIGPARMLIST, 'PHCM', (select name from v$database))
/
 
update psprcsrqst
set rundttm = rundttm + 2
where runstatus = '5'
/
 
update psprcsque
set rundttm = rundttm + 2
where runstatus = '5'
/
 
UPDATE PSPRCSRQST
SET RUNSTATUS = 4
WHERE RUNSTATUS IN (5)
/
 
UPDATE PSPRCSQUE
SET RUNSTATUS = 4
WHERE RUNSTATUS IN (5)
/
 
update psprcsrqst
set servernamerqst = 'PSUNX'
where servernamerqst in ('PSUNX1', 'PSUNX2')
/

update psprcsruncntls a
set a.servername = 'PSUNX'
where a.servername in ('PSUNX1', 'PSUNX2')
/

update ps_prcsdefn 
set servername='PSUNX' 
where servername='PSUNX1'
/

update ps_prcsdefn 
set servername='PSUNX' 
where servername='PSUNX2'
/

delete from PS_SERVERDEFN a
where a.servername = 'PSUNX2'
/

delete from PS_SERVERDEFN a
where a.servername = 'PSNT'
/

-- Report Node hrisrpt
 
update ps_cdm_dist_node 
set url = 'https://hris-rat.ds.acc.co.nz/psreports/ps',
opsys = '4',
uri_host = 'hris-rat.ds.acc.co.nz',
uri_port = '443',
uri_resource = 'SchedulerTransfer/ps',
uri_scheme = 'http',
uri_rpt='https://' || 'hris-rat.ds.acc.co.nz/psc/ps/EMPLOYEE/HRMS/c/CDM_RPT.CDM_RPT.GBL?Page=CDM_RPT_INDEX' || chr(38) || 'Action=U' || chr(38) || 'CDM_ID=',
cdm_dir_template = '%DBNAME%/%CURRDATE%/%REPORTID%'
where distnodename = 'hrisrpt'
/

-- Report Node hrisrpt1
 
update ps_cdm_dist_node 
set url = 'https://hris-rat.ds.acc.co.nz/psreports/ps',
opsys = '4',
uri_host = 'kdclea5081.ds.acc.co.nz',
uri_port = '8000',
uri_resource = 'SchedulerTransfer/ps',
uri_scheme = 'http',
uri_rpt='https://' || 'hris-rat.ds.acc.co.nz/psc/ps/EMPLOYEE/HRMS/c/CDM_RPT.CDM_RPT.GBL?Page=CDM_RPT_INDEX' || chr(38) || 'Action=U' || chr(38) || 'CDM_ID=',
cdm_dir_template = '%DBNAME%/%CURRDATE%/%REPORTID%'
where distnodename = 'hrisrpt1'
/

-- Report Node hrisrpt2
 
update ps_cdm_dist_node 
set url = 'https://hris-rat.ds.acc.co.nz/psreports/ps',
opsys = '4',
uri_host = 'kdclea5081.ds.acc.co.nz',
uri_port = '8000',
uri_resource = 'SchedulerTransfer/ps',
uri_scheme = 'http',
uri_rpt='https://' || 'hris-rat.ds.acc.co.nz/psc/ps/EMPLOYEE/HRMS/c/CDM_RPT.CDM_RPT.GBL?Page=CDM_RPT_INDEX' || chr(38) || 'Action=U' || chr(38) || 'CDM_ID=',
cdm_dir_template = '%DBNAME%/%CURRDATE%/%REPORTID%'
where distnodename = 'hrisrpt2'
/

-- URLs
 
update psurldefn 
set url = 'sftp://hrisftp:Rd1z2hoZjsJ3bqjkMEAD@kdclea5081.ds.acc.co.nz/opt/oracle/ftpattachment/PAYSLIPS'
where url_id = 'GP_SS_PSLP_FTP'
/

update psurldefn 
set url = 'https://hris-rat.ds.acc.co.nz/psp/ps/EMPLOYEE'
where url_id = 'EMP_SERVLET'
/

update psurldefn 
set url = 'https://hris-rat.ds.acc.co.nz/psp/ps/'
where url_id = 'TL_APPROVALS'
/
 
--  01/11/2015 New Code as part of Health & Safety Changes

UPDATE PSURLDEFN 
SET URL = 'uattest@hrisrat.ds.acc.co.nz'      -- Change UAT to DEV for E53HCM and SIT for E54HCM
  , LASTUPDOPRID = 'REFRESH'
  , LASTUPDDTTM = SYSDATE
WHERE URL_ID LIKE ('ACC_H%EMAIL');
/

UPDATE PSURLDEFN 
SET URL = 'peoplesoft@hrisrat.ds.acc.co.nz'      -- Change UAT to DEV for E53HCM and SIT for E54HCM
  , LASTUPDOPRID = 'REFRESH'
  , LASTUPDDTTM = SYSDATE
where URL_ID LIKE 'ACC_H%REPLYTO_EMAIL';
/

-- Integration Broker Domain

DELETE FROM PSAPMSGDSPSTAT WHERE MACHINENAME <> 'kdclea5081.ds.acc.co.nz' OR (APPSERVER_PATH <> '/opt/oracle/pt855/config/appserv/E58HCM' AND MACHINENAME= 'kdclea5081.ds.acc.co.nz')
/

DELETE FROM PSAPMSGDOMSTAT WHERE MACHINENAME <> 'kdclea5081.ds.acc.co.nz' OR (APPSERVER_PATH <> '/opt/oracle/pt855/config/appserv/E58HCM' AND MACHINENAME= 'kdclea5081.ds.acc.co.nz')
/

DELETE FROM PSAPMSGQUEUESET WHERE MACHINENAME <> 'kdclea5081.ds.acc.co.nz' OR (APPSERVER_PATH <> '/opt/oracle/pt855/config/appserv/E58HCM' AND MACHINENAME= 'kdclea5081.ds.acc.co.nz')
/

-- IB Domain update - run these next four Update steps after starting App Server with Pub/Sub active, or manually start the IB domain at the end
--                    from Main Menu > PeopleTools > Integration Broker > Service Operations Monitor > Administration > Domain Status
--
UPDATE PSAPMSGDOMSTAT SET DOMAIN_STATUS = 'A' WHERE MACHINENAME = 'kdclea5081.ds.acc.co.nz' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/E58HCM'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS = '0', STATUSSTRING = 'ACT' WHERE MACHINENAME = 'kdclea5081.ds.acc.co.nz' AND DISPATCHERNAME = 'PSBRKDSP_dflt' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/E58HCM'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS = '0', STATUSSTRING = 'ACT' WHERE MACHINENAME = 'kdclea5081.ds.acc.co.nz' AND DISPATCHERNAME = 'PSPUBDSP_dflt' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/E58HCM'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS = '0', STATUSSTRING = 'ACT' WHERE MACHINENAME = 'kdclea5081.ds.acc.co.nz' AND DISPATCHERNAME = 'PSSUBDSP_dflt' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/E58HCM'
/


--  **********************************************************************************************
--  INTEGRATION BROKER TRANSACTIONS (copied from appmsgpurgeall.dms)
--  Purges all Application Messaging queue data. Data in both live and archived tables are purged.
--  **********************************************************************************************

--  core tables:
DELETE FROM PSAPMSGPUBHDR
/
DELETE FROM PSAPMSGPUBDATA
/
DELETE FROM PSAPMSGPUBCON
/
DELETE FROM PSAPMSGSUBCON
/
DELETE FROM PSAPMSGPUBERR
/
DELETE FROM PSAPMSGPUBERRP
/
DELETE FROM PSAPMSGPUBCERR
/
DELETE FROM PSAPMSGPUBCERRP
/
DELETE FROM PSAPMSGSUBCERR
/
DELETE FROM PSAPMSGSUBCERRP
/
DELETE FROM PSAPMSGPCONDATA
/
DELETE FROM PSAPMSGSCONDATA
/
DELETE FROM PSIBERR
/
DELETE FROM PSIBERRP
/
DELETE FROM PSIBDEBUGLOG
/
DELETE FROM PSAPMSGIBATTR
/
DELETE FROM PSIBAEATTR
/
DELETE FROM PSIBRELMSGSEQ
/
DELETE FROM PSIBRELMSGHDR
/
DELETE FROM PSIBRELMSGDATA
/
DELETE FROM PSAPMSGDOMSTAT
/
DELETE FROM PSAPMSGDSPSTAT
/

-- synchronous core tables:
DELETE FROM PSIBLOGHDR
/
DELETE FROM PSIBLOGDATA
/
DELETE FROM PSIBLOGERR
/
DELETE FROM PSIBLOGERRP
/
DELETE FROM PSIBLOGIBINFO
/

-- archive tables:
DELETE FROM PSAPMSGARCHPH
/
DELETE FROM PSAPMSGARCHPD
/
DELETE FROM PSAPMSGARCHPC
/
DELETE FROM PSAPMSGARCHSC
/
DELETE FROM PSAPMSGARCHPT
/
DELETE FROM PSAPMSGARCHST
/
DELETE FROM PSIBLOGHDRARCH
/
DELETE FROM PSIBLOGDATAARCH
/
DELETE FROM PSIBLOGIBINFOAR
/

-- lock tables:
DELETE FROM PSIBFCLOCK
/
DELETE FROM PSIBADSLOCK
/


-- Integration Gateway
 
update psgateway
set connurl = 'https://hris-rat.ds.acc.co.nz/PSIGW/PeopleSoftListeningConnector'
/

-- Switch off IB Gateway Load Balancer setting for single app server environments
UPDATE PSIBLOADBALURL SET PT_IBGWLDBALURL = 'N'
/

-- Delete IB Gateway Load Balancer URLs for single app server environments
DELETE FROM PSIBLBURLS
/
DELETE FROM PSIBGATEWAYURLS
/


-- PSFT_HR NODE URI Text

update PSNODEURITEXT
set URI_TEXT = 'https://hris-rat.ds.acc.co.nz/psc/ps/'
where MSGNODENAME='PSFT_HR'
and URI_TYPE = 'CN'
/

update PSNODEURITEXT
set URI_TEXT = 'https://hris-rat.ds.acc.co.nz/psp/ps/'
where MSGNODENAME='PSFT_HR'
and URI_TYPE = 'PL'
/


-- PTWEBSERVER - ensure userid is unlocked
update psoprdefn set failedlogins=0, acctlock=0 where oprid='PTWEBSERVER'
/


-- Web Profile Virtual Addressing (required for SSL using proxy server)

delete from PSWEBPROFNVP where webprofilename in ('DEV', 'TEST', 'PROD') and propertyname in ('PSWEBSERVERNAME', 'DEFAULTSCHEME', 'DEFAULTPORT')
/
insert into PSWEBPROFNVP(webprofilename, propertyname, pt_propvalue, pt_lpropvalue) values('TEST', 'DEFAULTSCHEME', ' ', 'https')
/
insert into PSWEBPROFNVP(webprofilename, propertyname, pt_propvalue, pt_lpropvalue) values('TEST', 'DEFAULTPORT', ' ', '443')
/
insert into PSWEBPROFNVP(webprofilename, propertyname, pt_propvalue, pt_lpropvalue) values('TEST', 'PSWEBSERVERNAME', ' ', 'hris-rat.ds.acc.co.nz')
/

commit;
