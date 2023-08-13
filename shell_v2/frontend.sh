log=/tmp/roboshop.log
function_status() {
  if [ $? == 0 ]; then
      echo -e "\e[32msucess\e[0m"
    else
      echo -e "\e[31mfailure\e[0m"
fi
}

echo -e "\e[35m>>>>>> copying the config file <<<<<<<<<<\e[0m"
cp nginx.conf /etc/nginx/default.d/roboshop.conf  &>> $log
function_status

echo -e "\e[35m>>>>>>>>>>>>>installing >>>>>>>>>>>>\e[0m"
yum install nginx -y               &>> $log
function_status
rm -rf /usr/share/nginx/html/*     &>> $log
function_status

echo -e "\e[35m>>>>>>>>>>>>>>>>downloading app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip     &>> $log
function_status

cd /usr/share/nginx/html        &>> $log
function_status

echo -e "\e[35m>>>>>>>>>>>>>>>>unzipping app>>>>>>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/frontend.zip             &>> $log
function_status

echo -e "\e[35m>>>>>>>>>>>>>>>>systemctl commands>>>>>>>>>>>>>>>>>>>>>>[0m"
systemctl enable nginx
function_status
systemctl start nginx                  &>> $log
function_status
systemctl restart nginx                &>> $log
function_status

