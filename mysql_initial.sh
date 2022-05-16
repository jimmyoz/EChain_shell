#!/bin/bash
path=$(pwd);
mysql_p=LuoKuang@2022
accessRemote=1
user=root
pwdStr=$(grep "A temporary password" /var/log/mysqld.log)
pwd=$(echo $pwdStr|cut -d ":" -f4)
pwd1=$(echo ${pwd:1}) 
mysql_sq1="CREATE USER 'root'@'%' IDENTIFIED BY '$mysql_p';"
mysql_sq2="grant all privileges on *.* to 'root'@'%';"
mysql_sq3="ALTER USER 'root'@'%' IDENTIFIED BY '$mysql_p';"
mysql_sq4="ALTER USER 'root'@'%' IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY '$mysql_p';"
if [ "$accessRemote" = "0" ]
then
mysql_sq1=""
mysql_sq2=""
mysql_sq3=""
mysql_sq4=""	
fi

/usr/bin/mysql --socket=/var/lib/mysql/mysql.sock --connect-expired-password  -u$user -p"$pwd1" << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$mysql_p';
grant all privileges on *.* to 'root'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY '$mysql_p';
$mysql_sq1
$mysql_sq2
$mysql_sq3
$mysql_sq4
EOF
