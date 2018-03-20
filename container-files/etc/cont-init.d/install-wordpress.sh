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
    mkdir -p /etc/httpd/conf/vhosts
fi

 cat > /etc/httpd/conf/vhosts/wp_vhost <<EOF
 <VirtualHost *:80>
    ServerAdmin nis@esu10.org
    DocumentRoot "/var/www/html/wordpress"
    ServerName $DOMAIN_NAME
    ServerAlias *.$DOMAIN_NAME
    # ErrorLog /var/www/logs/ErrorLog
    # AccessLog /var/www/logs/AccessLog
    <Directory "/var/www/html/wordpress">
        Options FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
 </VirtualHost>
 
EOF

# 1) Check the contents of /var/www/html/wordpress/wp-content for our copied file.
# 2) If it exists, then this is not the first time we've created this instance and 
#     therefore we do nothing.
# 3) If it doesn't exist, then this is the first time we've created this instance
#     and we need to copy the /var/keep directory contents into that directory.
# 4) Finish by creating a copied file as our flag.

if [ ! -e /var/www/html/wordpress/wp-content/initialized ]; then
    #Do our stuff
    echo "wp-content directory found but not initialized. replacing mounted volume from /var/keep directory.";
    cp -r /var/keep/* /var/www/html/wordpress/wp-content/
    cd /var/www/html/wordpress/wp-content
    git init
    git config --global user.email "bcone@esu10.org"
    git config --global user.name "Docker Container"
    #Ignore filemode changes
    git config core.fileMode false
    git add .
    git commit -m 'Initial commit of source data'

    touch /var/www/html/wordpress/wp-content/initialized
else 
    echo "wp-content direcotry shows initilized file, not replacing mounted volume."
fi

#Lastly, make sure that our webserver has write permissions.
# We only need to do this once so make this a little more intelligent so that
# it doesn't hang so long on restarts and upgrades.
cd /var/www/html/wordpress

# Find any files or directories not owned by nobody:apache and change them to that.
find ./ -not -group apache -exec chown 'nobody:apache' '{}' \;
# Change file permissions
find ./ -not -path "*/wp-content/*" -not -type d -not -perm 755 -exec chmod '755' '{}' \;
find wp-content -type d -not -path "*/.git/*" -not -name .git -not -perm 775 -exec chmod -R '775' '{}' \;
echo "Finding anyone in the wp-content directory who is not 775."
# Cleanup
chmod 664 /var/www/html/wordpress/.htaccess
