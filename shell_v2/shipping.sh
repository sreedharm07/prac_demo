  cp shipping.service /etc/systemd/system/shipping.service   

  yum install maven -y    
  id roboshop
  if [ $? != 0 ]; then
        useradd roboshop    
  fi
  rm -rf /app    
  mkdir /app    
        echo -e "\e[36m--installing microservice--\e[0m"
  curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip     
  cd /app    
        echo -e "\e[36m--unzipping--\e[0m"
  unzip /tmp/shipping.zip    
  cd /app    
  mvn clean package     
  mv target/shipping-1.0.jar shipping.jar
        echo -e "\e[36m--systemctl commands--\e[0m"
  systemctl daemon-reload    
  systemctl enable shipping    
  systemctl start shipping   
  function_schema   
  systemctl restart shipping     
}