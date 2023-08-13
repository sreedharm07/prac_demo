source common.sh
cp mysql.repo /etc/yum.repos.d/mysql.repo  &>>log
 function_status

yum module disable mysql -y   &>>log
 function_status
yum install mysql-community-server -y   &>>log
 function_status

systemctl enable mysqld   &>>log
 function_status
systemctl start mysqld   &>>log
 function_status
mysql_secure_installation --set-root-pass RoboShop@1    &>>log
 function_status
