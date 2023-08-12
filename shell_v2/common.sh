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

  yum install mongodb-org-shell -y
  mongo --host 172.31.81.91 </app/schema/${component}.js
}