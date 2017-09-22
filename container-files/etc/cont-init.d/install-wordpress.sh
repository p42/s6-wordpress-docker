#!/usr/bin/with-contenv /bin/bash
cd /tmp
if [ -d /var/www/html/wordpress/wp-content ]; then
	echo "wp-content directory found, not overwriting";
else
	echo "wp-content directory not found, downloading";
	wget https://wordpress.org/latest.tar.gz; tar -xzf latest.tar.gz; cp -r wordpress/w-content/ /var/www/html/wordpress/wp-content; rm -r wordpress; rm latest.tar.gz;
fi

#Make sure that apache has write permissions
# echo "Variables not yet set"

#  MYSQL_ROOT_PASSWORD_ENV=${MYSQL_ROOT_PASSWORD:=root}
#  MYSQL_DATABASE_ENV=${MYSQL_DATABASE:=wordpress}
#  MYSQL_USER_ENV=${MYSQL_DATABASE:=froot}
#  MYSQL_PASSWORD_ENV=${MYSQL_PASSWORD:=froot}
#  DATABASE_PREFIX_ENV=${DATABASE_PREFIX:=wp_}

#  echo ${MYSQL_ROOT_PASSWORD}