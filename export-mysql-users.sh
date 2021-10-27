#!/bin/bash
#Created by Gerodin
#www.techies-world.com

#MySQL server credentials
HOST=
USER=
PASSWORD=

#Collecting the users list and privileges
for i in `mysql -Ns -h $HOST -u $USER -p$PASSWORD -e "select concat('\'',user,'\'@\'',host,'\'') from mysql.user where user not in ('mysql.session','mysql.sys','debian-sys-maint','root');"`
do
mysql -Ns -h $HOST -u $USER -p$PASSWORD -e 'SHOW CREATE USER '"$i"';' >> users.sql
mysql -Ns -h $HOST -u $USER -p$PASSWORD -e 'SHOW GRANTS FOR '"$i"';' >> users.sql
done

#Appending ; to the end of the quries
sed -i 's/$/\;/' users.sql
