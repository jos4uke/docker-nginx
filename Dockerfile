FROM nginx

MAINTAINER	Joseph Tran <Joseph.Tran@versailles.inra.fr>

# set locales
RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8

# set timezone
RUN echo "Europe/Paris" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# copy base conf
ADD conf/all/nginx.conf /etc/nginx/
ADD conf/all/proxy.conf /etc/nginx/conf.d/

# fix a blank php page rendering with php-fpm
RUN echo "\n# fix blank php page rendering with php-fpm\nfastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_script_name;" >> /etc/nginx/fastcgi_params

RUN usermod -u 1000 www-data

VOLUME /usr/share/nginx/html
VOLUME /etc/nginx
