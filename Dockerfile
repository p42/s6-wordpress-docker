FROM project42/s6-centos-apache-docker
MAINTAINER Brandon Cone bcone@esu10.org

#Set up a wordpress instantiation. This is independent of a webserver, etc, even though it
#inherets from it because we want these to be standalone. We will use a composition (docker-compose.yml)
#to actually start all the services and get this running and talking to the database, etc.

RUN yum install -y php56w-mysqlnd && \
	cd /tmp && \
	wget https://wordpress.org/latest.tar.gz  && \
	tar xzf latest.tar.gz -C /var/www/html/ && \
	rm latest.tar.gz && \
	yum -y clean all

COPY container-files /