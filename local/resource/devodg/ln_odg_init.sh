if [ $# -lt 1 ]; then
	echo "usage: ${0} <env_number>"
	exit 1
else
	env_id=${1}
	init_base=${LOCAL_TOP}/resource/devodg/ENV${env_id}
	#odg_home=/u002/app/oracle/product/11.2.0.4/gateway
	odg_home=/u002/app/oracle/product/11.2.0.4/ebs_dg
fi

for orafile in initMDL${env_id}09a.ora initMDL${env_id}09b.ora initMDL${env_id}14a_inv.ora initMDL${env_id}14b_inv.ora initMDL${env_id}14a_ips2.ora initMDL${env_id}14b_ips2.ora; do
	if [ -f ${init_base}/${orafile} ]; then
		ln -sf ${init_base}/${orafile} ${odg_home}/dg4sybs/admin/${orafile}
	else
		echo "Error: ${init_base}/${orafile} does not exist"
	fi
done
