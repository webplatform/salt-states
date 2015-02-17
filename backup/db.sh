#!/bin/bash

for i in `mysql -BNe 'show databases'`
do
	if [ "${i}" == "wptestwiki" ]
	then
		continue
	fi
	if [ "${i}" == "information_schema" ]
	then
		continue
	fi
	if [ "${i}" == "mysql" ]
	then
		continue
	fi
	if [ "${i}" == "performance_schema" ]
	then
		continue
	fi
	nice -n 19 mysqldump -u root ${i} -c | nice -n 19 gzip -9 > /mnt/backup/${i}-$(date '+%Y%m%d').sql.gz
done
