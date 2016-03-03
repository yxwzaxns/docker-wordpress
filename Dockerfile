FROM ubuntu:latest
MAINTAINER aong <yxwzaxns@gmail.com>
RUN groupadd user && useradd --create-home --home-dir /home/user -g user user
RUN apt-get update # Fri Oct 24 13:09:23 EDT 2014
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql  php5-ldap
ADD ./scripts/start.sh /start.sh
ADD ./configs/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN rm -rf /var/www/
ADD https://wordpress.org/latest.tar.gz /wordpress.tar.gz
RUN tar xvzf /wordpress.tar.gz
RUN mv /wordpress /var/www/
RUN chown -R www-data:www-data /var/www/
RUN chmod 755 /start.sh
ENV WP_SOURCE /var/www
ENV WP_CONTENT /var/www/volume/wp-content
ENV VOLUME /var/www/volume
VOLUME $VOLUME
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
