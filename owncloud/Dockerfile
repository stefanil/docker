FROM ubuntu:14.04
MAINTAINER Stefan Illgen "stefan@digitill-network.de"

# Prevent the base image to change policy-rc.d to stop services from being configured by apt
RUN rm /usr/sbin/policy-rc.d

# Setup apt to be happy with no console input
ENV DEBIAN_FRONTEND noninteractive

# Install some nifty tools
RUN apt-get update && apt-get install -y wget vim tree ssh

# Install MySQL
#ADD ./setup_mysql.sh /setup_mysql.sh
#RUN chmod 755 /setup_mysql.sh
#RUN /setup_mysql.sh
#EXPOSE 3306
#CMD ["/usr/sbin/mysqld"]


# add owncloud repository
RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community:/7.0/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list
RUN wget 'http://download.opensuse.org/repositories/isv:/ownCloud:/community:/7.0/xUbuntu_14.04/Release.key'
RUN apt-key add - < Release.key
RUN apt-get update --fix-missing
RUN apt-get -y upgrade

# install owncloud
RUN apt-get install -y owncloud=7.0.3-1

ADD data/apache2/conf-available/owncloud.conf /etc/apache2/conf-available/
ADD data/apache2/sites-available/000-default.conf /etc/apache2/sites-available/
#RUN ln -s /etc/apache2/sites-available/owncloud.conf /etc/apache2/sites-enabled/

#RUN a2enmod ssl
#RUN a2ensite default-ssl
RUN a2ensite 000-default.conf
RUN a2enmod rewrite

EXPOSE 80
#EXPOSE 443

# Create missing environement variables
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_RUN_DIR   /etc/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
RUN mkdir APACHE_LOCK_DIR && chown $APACHE_RUN_USER:$APACHE_RUN_GROUP $APACHE_LOCK_DIR

# Run the Apache Server

## Aproach A:
CMD ["/usr/sbin/apache2", "-DNO_DETACH", "-DFOREGROUND", "-c", "ErrorLog /dev/stdout"]
