FROM php:8.2-fpm

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy public directory from build context (docker/) to the web root
COPY ./public /var/www/html

# Copy custom Nginx configuration
COPY ./nginx.conf /etc/nginx/sites-enabled/default

# Expose port 80
EXPOSE 80

# Start both PHP-FPM and Nginx using a simple shell script
CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]

