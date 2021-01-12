#!/bin/sh

_LSNR_ODG=LISTENER_ODG
_LSNR_HOME=/u002/app/oracle/product/11.2.0.4/ebs_dg

#env | sort > /orabackup/env.log
#set | sort > /orabackup/set.log
#echo "$1" >> /orabackup/action.log
#exit 0

export ORACLE_HOME="${_LSNR_HOME}"
export PATH=${ORACLE_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${ORACLE_HOME}/dg4sybs/driver/lib:${ORACLE_HOME}/dg4sybs/lib:${ORACLE_HOME}/lib:${ORACLE_HOME}/ctx/lib:${LD_LIBRARY_PATH}

case $1 in
'start')
   echo "running ${ORACLE_HOME}/bin/lsnrctl start ${_LSNR_ODG}"
   ${ORACLE_HOME}/bin/lsnrctl start ${_LSNR_ODG}
   RET=$?
   :;;
'stop')
   echo "running ${ORACLE_HOME}/bin/lsnrctl stop ${_LSNR_ODG}"
   ${ORACLE_HOME}/bin/lsnrctl stop ${_LSNR_ODG}
   RET=$?
   :;;
'clean')
   echo "running ${ORACLE_HOME}/bin/lsnrctl reload ${_LSNR_ODG}"
   ${ORACLE_HOME}/bin/lsnrctl reload ${_LSNR_ODG}
   RET=$?
   :;;
'check')
   echo "running ${ORACLE_HOME}/bin/lsnrctl status ${_LSNR_ODG}"
   ${ORACLE_HOME}/bin/lsnrctl status ${_LSNR_ODG}
   RET=$?
   :;;
*)
   RET=0
   :;;
esac
# 0: success; 1 : error
if [ $RET -eq 0 ]; then
   exit 0
else
   exit 1
fi

