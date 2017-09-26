FROM project42/s6-centos-apache-docker
MAINTAINER Brandon Cone bcone@esu10.org

#Set up a wordpress instantiation. This is independent of a webserver, etc, even though it
#inherets from it because we want these to be standalone. We will use a composition (docker-compose.yml)
#to actually start all the services and get this running and talking to the database, etc.

ENV WP_VERSION 4.8.2
ENV WP_MD5 2e8744a702a3d9527782d9135a4c9544

RUN yum install -y php56w-mysqlnd && \
cd /tmp && \
wget https://wordpress.org/wordpress-${WP_VERSION}.tar.gz && \
echo "$WP_MD5 *wordpress-$WP_VERSION.tar.gz" | md5sum -c - && \
tar xzf wordpress-${WP_VERSION}.tar.gz -C /var/www/html/ && \
rm -f wordpress-${WP_VERSION} && \
mkdir /var/keep && \
cp -r /var/www/html/wordpress/wp-content/ /var/keep/ && \
echo "Contents of keep directory" && \
ls /var/keep && \
# wget https://wordpress.org/latest.tar.gz  && \
# tar xzf latest.tar.gz -C /var/www/html/ && \
# rm latest.tar.gz && \
yum -y clean all

COPY container-files /