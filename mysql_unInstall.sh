#!/bin/bash
systemctl stop mysqld 
kill -9 $(pidof mysqld)
rm -rf  /root/.mysql_history
rm -rf  /root/mysql_secret
rm -rf /var/log/mysqld.log 
rm -rf /etc/my.ini
rm -rf /etc/my.cnf
yum remove  mysql* -y
yum remove  mysql-* -y
yum remove -y $(rpm -qa |grep -i mysql)
find / -name mysql -exec rm -rf {} \;
