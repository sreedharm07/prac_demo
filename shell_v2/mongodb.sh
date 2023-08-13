log=/tmp/roboshop.log
function_status(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32m---success---\e[0m"
    else
      echo -e "\e[31m----failure---\e[0m"
      fi
}

cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> log
function_status

yum install mongodb-org -y      &>> log
function_status

systemctl start mongod         &>> log
function_status

systemctl enable mongod         &>> log
function_status


#sed -i 's \127.0.0.1\0.0.0.0\' /etc/mongod.conf      &>> log
function_status

systemctl restart mongod      &>> log
function_status
