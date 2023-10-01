sudo pkill apache
sudo yum erase -y httpd httpd-tools apr apr-util
sudo yum install -y nginx

sudo cp nginx.conf /etc/nginx/sites-available/default
sudo /etc/init.d/nginx start
nginx -s reload
sudo service nginx restart
sudo service nginx status
