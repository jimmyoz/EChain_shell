mysql_u=root
mysql_p=LuoKuang@2022
accessRemote=0
path1=$(pwd)
pwdStr=$(grep "A temporary password" /var/log/mysqld.log)
pwd=$(echo $pwdStr|cut -d ":" -f4)
pwd1=$(echo ${pwd:1}) 
save_f="sql_result.txt"
mysql_sq1="CREATE USER 'root'@'%' IDENTIFIED BY $mysql_p;"
mysql_sq2="grant all privileges on *.* to 'root'@'%';"
mysql_sq3="ALTER USER 'root'@'%' IDENTIFIED BY $mysql_p;"
mysql_sq4="ALTER USER 'root'@'%' IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY $mysql_p;"
if [ "$accessRemote" = "1" ]
then
mysql_sq1=""
mysql_sq2=""
mysql_sq3=""
mysql_sq4=""	
fi
mysql_sq3="grant all privileges on *.* to 'root'@'%';"
echo "开始链接数据库..."
# 2.连接数据库
result=`/usr/bin/mysql --socket=/var/lib/mysql/mysql.sock -u$mysql_u -p"$pwd1" << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY $mysql_p;
set global validate_password_length=6;
set global validate_password_policy=0;
set global validate_password_check_user_name=off;
grant all privileges on *.* to 'root'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY $mysql_p;
$mysql_sq1
$mysql_sq2
$mysql_sq3
$mysql_sq4
EOF`
# 判断是否连接成功
if [ $? = 0 ]
then
echo "连接成功。。。"
else
echo "连接失败。。。"
exit
fi
echo "写入查询结果..."
# 将结果写入文本
echo "$result" > $path1/$save_f
echo "写入完成..."