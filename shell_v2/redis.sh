source common.sh
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>>log
 function_status
yum module enable redis:remi-6.2 -y   &>>log
 function_status
yum install red -y   &>>log
 function_status
systemctl enable redis   &>>log
function_status
systemctl start redis    &>>log
 function_status