echo -e "\e[32m>>>>>> copying the config file <<<<<<<<<<\e[0m"
cp nginx.conf /etc/nginx/default.d/roboshop.conf  &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>>>>>>>>installing >>>>>>>>>>>>\e[0m"
yum install nginx -y               &>> /tmp/roboshop.log
rm -rf /usr/share/nginx/html/*     &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>>>>>>>>>>>downloading app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip     &>> /tmp/roboshop.log

cd /usr/share/nginx/html        &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>>>>>>>>>>>unzipping app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/frontend.zip             &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>>>>>>>>>>>systemctl commands>>>>>>>>>>>>>>>>>>>>>>[0m"
systemctl enable nginx
systemctl start nginx                  &>> /tmp/roboshop.log
systemctl restart nginx                &>> /tmp/roboshop.log
