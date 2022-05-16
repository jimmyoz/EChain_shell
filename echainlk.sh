path=$(pwd)
mysql_p=LuoKuang@2022
user=root
/usr/bin/mysql --socket=/var/lib/mysql/mysql.sock --connect-expired-password  -u$user -p"$mysql_p" << EOF
drop database if exists echainlk;
create database echainlk;
use echainlk; 
source $path/echainlk.sql;
delete from user_certification;
delete from account_info;
delete from business_data;
delete from contract_account;
delete from preaccount_info;
delete from  user_register where id not in (select * from  (select  min(id) from user_register) a);
update user_register set blockaddress='ea01c16299cd75dd6d106e17f00ae8b71bf4ab11a3d234',publickey='eb010a89e5368e106d69bd363b984707e9d18febeb8ceabfe96dd15b3b82cea61665f2',privatekey='ec017880137471e586542bb203de30563039cb19c2d7975eb29680fcd4947e4699d7b0',transactionhash='5efb1cd487e874d35210781e79b694d991f151794fe557bcab5ad2dc2af54d3';
EOF
