FROM nginx:latest

ADD default.conf /etc/nginx/conf.d/default.conf

COPY public /var/www/public