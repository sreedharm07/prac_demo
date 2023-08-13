log=/tmp/roboshop.log

function_nodejs() {
  echo -e "\e[36m--copying--\e[0m"
  cp ${component}.service  /etc/systemd/system/${component}.service   &>>$log
  function_status
  cp mongo.repo /etc/yum.repos.d/mongo.repo          &>>$log
   function_status

  echo -e "\e[36m--downloading repos--\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash    &>>$log
   function_status

    echo -e "\e[36m--installing--\e[0m"
  yum install nodejs -y   &>>$log
   function_status
   id roboshop    &>>$log
   if [ $? != 0 ]; then
  useradd roboshop    &>>$log
   function_status
   fi
  rm -rf /app       &>>$log
  function_status
  mkdir /app        &>>$log
   function_status
    echo -e "\e[36m--downloading--\e[0m"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip     &>>$log
   function_status

  cd /app      &>>$log
   function_status
    echo -e "\e[36m--unzipping--\e[0m"
  unzip /tmp/${component}.zip     &>>$log
   function_status
  cd /app     &>>$log
   function_status
  npm install     &>>$log
   function_status

  echo -e "\e[36m--systemctl commands--\e[0m"
  systemctl daemon-reload    &>>$log
   function_status
  systemctl start ${component}    &>>$log
   function_status
  systemctl enable ${component}     &>>$log
   function_status
  function_schema
}
#------------------------------------------------------------------------------------------------------
function_schema () {
  if [ "${schema_type}" == "mongodb" ]; then
        echo -e "\e[36m--mongoodb schema--\e[0m"
  yum install mongodb-org-shell -y      &>>$log | function_status
  mongo --host 172.31.81.91 </app/schema/${component}.js      &>>$log | function_status
  fi

  if [ "${schema_type}" == "mysql" ]; then
    echo -e "\e[36m--mysql schema--\e[0m"
  yum install mysql -y     &>>$log | function_status
  mysql -h 172.31.93.1 -uroot -pRoboShop@1 < /app/schema/${component}.sql     &>>$log | function_status

  fi
}
#--------------------------------------------------------------------------------------------------------
function_maven(){
      echo -e "\e[36m--copying--\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service    &>>$log | function_status

      echo -e "\e[36m--installing app--\e[0m"
  yum install lapamkiririr -y    &>>$log | function_status
  useradd roboshop    &>>$log | function_status
  rm -rf /app    &>>$log | function_status
  mkdir /app    &>>$log | function_status
        echo -e "\e[36m--installing microservice--\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip     &>>$log | function_status
  cd /app    &>>$log | function_status
        echo -e "\e[36m--unzipping--\e[0m"
  unzip /tmp/${component}.zip    &>>$log | function_status
  cd /app    &>>$log | function_status
  mvn clean package     &>>$log | function_status
  mv target/shipping-1.0.jar ${component}.jar    &>>$log | function_status
        echo -e "\e[36m--systemctl commands--\e[0m"
  systemctl daemon-reload    &>>$log | function_status
  systemctl enable ${component}    &>>$log | function_status
  systemctl start ${component}   &>>$log | function_status
  function_schema   &>>$log | function_status
  systemctl restart ${component}     &>>$log | function_status
}
#-----------------------------------------------------------------------------------------------------------
function_python(){
        echo -e "\e[36m--copying--\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service   &>>$log | function_status
      echo -e "\e[36m--installing python--\e[0m"
  yum install python36 gcc python3-devel -y    &>>$log | function_status
  useradd roboshop    &>>$log | function_status
  rm -rf /app    &>>$log | function_status
  mkdir /app     &>>$log | function_status
        echo -e "\e[36m--downloading service--\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip    &>>$log | function_status
  cd /app    &>>$log | function_status
        echo -e "\e[36m--unzipping service--\e[0m"
  unzip /tmp/payment.zip    &>>$log | function_status
  cd /app    &>>$log | function_status
  pip3.6 install -r requirements.txt    &>>$log | function_status\
        echo -e "\e[36m--systemctl commands--\e[0m"
  systemctl daemon-reload    &>>$log | function_status
  systemctl enable ${component}    &>>$log | function_status
  systemctl start ${component}    &>>$log | function_status
}
#-----------------------------------------------------------------------------------------------------------
function_golang(){
        echo -e "\e[36m--copying repos--\e[0m"
cp ${component}.service /etc/systemd/system/${component}.service    &>>$log | function_status
      echo -e "\e[36m--installing golang--\e[0m"
yum install golang -y     &>>$log | function_status
useradd roboshop    &>>$log | function_status
rm -rf /app     &>>$log | function_status
mkdir /app     &>>$log | function_status
      echo -e "\e[36m--downloading service--\e[0m"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip     &>>$log | function_status
cd /app     &>>$log | function_status
      echo -e "\e[36m--unzipping service--\e[0m"
unzip /tmp/${component}.zip     &>>$log | function_status
cd /app     &>>$log | function_status
go mod init ${component}     &>>$log | function_status
go get     &>>$log | function_status
go build     &>>$log | function_status
      echo -e "\e[36m--systemctl commands--\e[0m"
systemctl daemon-reload     &>>$log | function_status
systemctl enable ${component}      &>>$log | function_status
systemctl start ${component}       &>>$log | function_status
}
#-----------------------------------------------------------------------------------------------------------
function_status(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32m---success---\e[0m"
    else
      echo -e "\e[31m---failure--\e[om"
      fi
}