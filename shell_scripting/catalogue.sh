cp catalogue.service  /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install

systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue

yum install mongodb-org-shell -y
mongo --host 172.31.90.137 </app/schema/catalogue.js