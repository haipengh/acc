-- IB Domain update - run these next four Update steps after starting App Server with Pub/Sub active, or manually start the IB domain at the end
--                    from Main Menu > PeopleTools > Integration Broker > Service Operations Monitor > Administration > Domain Status
--
UPDATE PSAPMSGDOMSTAT SET DOMAIN_STATUS = 'A' WHERE MACHINENAME = 'kdclea5053.ds.acc.co.nz' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/HR92DEV'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS = '0', STATUSSTRING = 'ACT' WHERE MACHINENAME = 'kdclea5053.ds.acc.co.nz' AND DISPATCHERNAME = 'PSBRKDSP_dflt' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/HR92DEV'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS = '0', STATUSSTRING = 'ACT' WHERE MACHINENAME = 'kdclea5053.ds.acc.co.nz' AND DISPATCHERNAME = 'PSPUBDSP_dflt' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/HR92DEV'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS = '0', STATUSSTRING = 'ACT' WHERE MACHINENAME = 'kdclea5053.ds.acc.co.nz' AND DISPATCHERNAME = 'PSSUBDSP_dflt' AND APPSERVER_PATH = '/opt/oracle/pt855/config/appserv/HR92DEV'
/
commit
/