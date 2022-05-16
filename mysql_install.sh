systemctl stop mysqld
kill -9 $(pidof mysqld)
yum remove mysql* -y
wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql-community-server --nogpgcheck 
systemctl start mysqld.service