component=shipping
function_status(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32msuccess\e[0m"
      else
            echo -e "\e[31mfailure\e[0m"
  fi
  }

  cp ${component}.service /etc/systemd/system/${component}.service
   function_status

      echo -e "\e[36m--installing app------------\e[0m"
  yum install mavre -y
   function_status
  id roboshop
  if [ $? != 0 ]; then
        useradd roboshop
         function_status
  fi
  rm -rf /app
  function_status
  mkdir /app
  function_status
        echo -e "\e[36m--installing microservice--\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
   function_status
  cd /app
   function_status
        echo -e "\e[36m--unzipping--\e[0m"
  unzip /tmp/${component}.zip
   function_status
  cd /app
    function_status
  mvn clean package
    function_status
  rm -rf shipping.jar
  mv target/shipping-1.0.jar ${component}.jar
   function_status
        echo -e "\e[36m--systemctl commands--\e[0m"
  systemctl daemon-reload
  function_status
  systemctl enable ${component}
    function_status
  systemctl start ${component}
   function_status
  yum install mysql -y
   function_status
    mysql -h 172.31.93.1 -uroot -pRoboShop@1 < /app/schema/${component}.sql
  function_status
  systemctl restart ${component}
     function_status