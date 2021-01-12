ff=oratab_kdclor5101.ds.acc.co.nz

for i in `seq 2 6`; do
	tt=../kdclor510${i}.ds.acc.co.nz/oratab_kdclor510${i}.ds.acc.co.nz
	echo "... generate ${tt}"
	eval "cat ${ff} | sed 's/+ASM1/+ASM${i}/g'" > ${tt}.new
	diff ${tt} ${tt}.new
	mv ${tt}.new ${tt}
	echo
done
