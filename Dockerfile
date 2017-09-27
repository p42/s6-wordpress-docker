FROM project42/centos-apache
MAINTAINER Brandon Cone bcone@esu10.org

# Set up a wordpress instantiation. This is independent of a webserver, etc, even though it
# inherets from it because we want these to be standalone.

ENV WP_VERSION 4.8.2
ENV WP_MD5 2e8744a702a3d9527782d9135a4c9544

RUN yum install -y php56w-mysqlnd && \
cd /tmp && \
wget https://wordpress.org/wordpress-${WP_VERSION}.tar.gz && \
echo "$WP_MD5 *wordpress-$WP_VERSION.tar.gz" | md5sum -c - && \
tar xzf wordpress-${WP_VERSION}.tar.gz -C /var/www/html/ && \
rm -f wordpress-${WP_VERSION} && \
mkdir /var/keep && \
# Because of how volumes are mounted, volumes will "hide" what was downloaded
# so we copy out as part of setting persistence. 
# This process completes in our install-wordpress.sh file.
cp -r /var/www/html/wordpress/wp-content/* /var/keep/ && \
echo "Contents of keep directory" && \
ls /var/keep && \
yum -y clean all

COPY container-files /