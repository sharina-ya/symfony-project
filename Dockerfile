FROM php:8.2-fpm

# системные зависимости
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libpq-dev


RUN docker-php-ext-install pdo_pgsql pgsql mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Создаем рабочую директорию
WORKDIR /var/www

COPY . .

RUN chown -R www:www /var/www

USER www

EXPOSE 9000

CMD ["php-fpm"]