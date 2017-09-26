#!/usr/bin/with-contenv /bin/bash

#Configurations specific to how we want to install and use
#Wordpress need to be here and not in the Apache Container.
#The question right now is if this runs prior to or following
#the apache start command. If it is before, then we can write
#our vhost file. If not, we need to figure out how to restart
#the apache container after we create our vhost file.

 #Write vhost file to the vhosts directory that will:
 # 1) Update the Apache Document Root
 # 2) Map the supplied URL to the Wordpress instance
 # 3) Set up error logging

#First, make sure the directory exists - in the event that this script
# runs before the apache one.
if [ -d /etc/httpd/conf/vhosts ]; then
    echo "Vhosts directory exists"
    #Do nothing
else
    echo "CREATING VHOSTS DIRECTORY FROM WORDPRESS RUN SCRIPT"
    mkdir /etc/httpd/conf/vhosts
fi
 cat > /etc/httpd/conf/vhosts/vhost <<EOF
 <VirtualHost *:80>
    ServerAdmin brandon@esu10.org
    DocumentRoot "/var/www/html/wordpress"
    ServerName mydevsite.com
    # ErrorLog /var/www/logs/ErrorLog
    # AccessLog /var/www/logs/AccessLog
 </VirtualHost>
 
EOF

# 1) Check the contents of /var/www/html/wordpress/wp-content for our copied file.
# 2) If it exists, then this is not the first time we've created this instance and 
#     therefore we do nothing.
# 3) If it doesn't exist, then this is the first time we've created this instance
#     and we need to copy the /var/keep directory contents into that directory.
# 4) Finish by creating a copied file as our flag.

if [ !-e /var/www/html/wordpress/wp-content/initialized ]; then
    #Do our stuff
    echo "wp-content directory found but not initialized. replacing mounted volume from /var/keep directory.";
    cp -r /var/keep/ /var/www/html/wordpress/wp-content/
    touch /var/www/html/wordpress/wp-content/initialized
else 
    echo "wp-content direcotry shows initilized file, not replacing mounted volume."
fi

# cd /tmp
# if [ -d /var/www/html/wordpress/wp-content ]; then
# 	echo "wp-content directory found, not overwriting";
#     ls /var/www/html/wordpress/wp-content/themes
# else
# 	echo "wp-content directory not found, downloading";
# 	wget https://wordpress.org/latest.tar.gz; tar -xzf latest.tar.gz; cp -r wordpress/w-content/ /var/www/html/wordpress/wp-content; rm -r wordpress; rm latest.tar.gz;
# fi

