FROM nginx

MAINTAINER	Joseph Tran <Joseph.Tran@versailles.inra.fr>

# set locales
RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8

COPY content /usr/share/nginx/html

ADD conf/nginx.conf /etc/nginx/
ADD conf/proxy.conf /etc/nginx/conf.d/
#ADD conf/kube-ui.conf /etc/nginx/sites-available/
ADD conf/vm-db.conf /etc/nginx/sites-available/

# fix a blank php page rendering with php-fpm
RUN echo "\n# fix blank php page rendering with php-fpm\nfastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_script_name;" >> /etc/nginx/fastcgi_params

RUN mkdir /etc/nginx/sites-enabled/
#RUN ln -s /etc/nginx/sites-available/kube-ui.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/vm-db.conf /etc/nginx/sites-enabled/

#RUN rm /etc/nginx/sites-enabled/default
#RUN rm /etc/nginx/conf.d/example_ssl.conf

RUN usermod -u 1000 www-data

VOLUME /usr/share/nginx/html
VOLUME /etc/nginx
