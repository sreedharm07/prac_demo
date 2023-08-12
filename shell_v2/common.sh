function_nodejs() {
  cp ${component}.service  /etc/systemd/system/${component}.service
  cp mongo.repo /etc/yum.repos.d/mongo.repo

  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  yum install nodejs -y
  useradd roboshop
  rm -rf /app
  mkdir /app
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app
  unzip /tmp/${component}.zip
  cd /app
  npm install

  systemctl daemon-reload
  systemctl start ${component}
  systemctl enable ${component}
  function_schema
}
#------------------------------------------------------------------------------------------------------
function_schema () {
  if [ "${schema_type}" == "mongodb" ]; then
  yum install mongodb-org-shell -y
  mongo --host 172.31.81.91 </app/schema/${component}.js
  fi

  if [ "${schema_type}" == "mysql" ]; then
  yum install mysql -y
  mysql -h 172.31.93.1 -uroot -pRoboShop@1 < /app/schema/${component}.sql
  fi
}
#--------------------------------------------------------------------------------------------------------
function_maven(){
  cp ${component}.service /etc/systemd/system/${component}.service

  yum install maven -y
  useradd roboshop
  rm -rf /app
  mkdir /app
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app
  unzip /tmp/${component}.zip
  cd /app
  mvn clean package
  mv target/shipping-1.0.jar ${component}.jar
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
  function_schema
  systemctl restart ${component}
}
#-----------------------------------------------------------------------------------------------------------
function_golang(){
  cp ${component}.service /etc/systemd/system/${component}.service

  yum install python36 gcc python3-devel -y
  useradd roboshop
  rm -rf /app
  mkdir /app
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app
  unzip /tmp/payment.zip
  cd /app
  pip3.6 install -r requirements.txt
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
}