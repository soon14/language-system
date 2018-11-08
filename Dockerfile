FROM php:5.6-apache

RUN apt-get -y update && apt-get -y install ffmpeg
COPY src/* /var/www/html/
COPY setup/php.ini /usr/local/etc/php
RUN apt-get -y install sudo
RUN apt-get -y install python-pip
RUN pip install autosub
RUN apt-get -y install espeak
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN sudo -H -u www-data bash -c 'php composer.phar require stichoza/google-translate-php'
