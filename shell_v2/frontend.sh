echo ">>>>>>>>>>>>>>>>copying the config>>>>>>>>>>>>>>>>>>>>>>"
cp nginx.conf /etc/nginx/default.d/roboshop.conf  &>> /tmp/roboshop.log

echo ">>>>>>>>>>>>>>>>installing nginx>>>>>>>>>>>>>>>>>>>>>>"
yum install nginx -y               &>> /tmp/roboshop.log
rm -rf /usr/share/nginx/html/*     &>> /tmp/roboshop.log

echo ">>>>>>>>>>>>>>>>downloading app>>>>>>>>>>>>>>>>>>>>>>"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip     &>> /tmp/roboshop.log

cd /usr/share/nginx/html        &>> /tmp/roboshop.log

echo ">>>>>>>>>>>>>>>>unzipping app>>>>>>>>>>>>>>>>>>>>>>"
unzip /tmp/frontend.zip             &>> /tmp/roboshop.log

echo ">>>>>>>>>>>>>>>>systemctl commands>>>>>>>>>>>>>>>>>>>>>>"
systemctl enable nginx
systemctl start nginx                  &>> /tmp/roboshop.log
systemctl restart nginx                &>> /tmp/roboshop.log
