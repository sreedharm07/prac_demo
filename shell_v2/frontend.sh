echo ">>>>>>>>>>>>>>>>copying the config>>>>>>>>>>>>>>>>>>>>>>"
cp nginx.conf /etc/nginx/default.d/roboshop.conf

echo ">>>>>>>>>>>>>>>>installing nginx>>>>>>>>>>>>>>>>>>>>>>"
yum install nginx -y
rm -rf /usr/share/nginx/html/*

echo ">>>>>>>>>>>>>>>>downloading app>>>>>>>>>>>>>>>>>>>>>>"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html

echo ">>>>>>>>>>>>>>>>unzipping app>>>>>>>>>>>>>>>>>>>>>>"
unzip /tmp/frontend.zip

echo ">>>>>>>>>>>>>>>>systemctl commands>>>>>>>>>>>>>>>>>>>>>>"
systemctl enable nginx
systemctl start nginx
systemctl restart nginx
