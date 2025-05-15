FROM php:8.2-fpm

# Install Nginx
RUN apt-get update && apt-get install -y nginx

COPY ./public /var/www/html
COPY ./docker/nginx.conf /etc/nginx/sites-enabled/default

EXPOSE 80

CMD ["php-fpm"]
