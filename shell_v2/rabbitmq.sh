source common.sh
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash    &>>log | function_status
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash   &>>log | function_status

yum install rabbitmq-server -y   &>>log | function_status

systemctl enable rabbitmq-server   &>>log | function_status
systemctl start rabbitmq-server    &>>log | function_status

rabbitmqctl add_user roboshop roboshop123     &>>log | function_status
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"     &>>log | function_status