
# a. SETUP LARAVEL WORKERS (jalankan di Elendil, Isildur, Anarion)

# jangan lupa ganti 
cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
EOF


# 1. update repo 
apt-get update

# 2. install dependencies
apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2

# 3. add PHP 8.4 repository (Sury)
curl -sSL https://packages.sury.org/php/README.txt | bash -x
apt-get update

# 4. install PHP 8.4 dan extensions
apt-get install -y php8.4 php8.4-fpm php8.4-cli php8.4-common php8.4-mysql php8.4-xml php8.4-curl php8.4-mbstring php8.4-zip php8.4-gd php8.4-intl php8.4-bcmath

# 5. install Nginx
apt-get install -y nginx

# 6. install Composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 7. install Git & unzip
apt-get install -y git unzip


# install cepat
apt-get update
apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
curl -sSL https://packages.sury.org/php/README.txt | bash -x
apt-get update
apt-get install -y php8.4 php8.4-fpm php8.4-cli php8.4-common php8.4-mysql php8.4-xml php8.4-curl php8.4-mbstring php8.4-zip php8.4-gd php8.4-intl php8.4-bcmath
apt-get install -y nginx
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
apt-get install -y git unzip



# 8. Verifikasi instalasi
php -v
composer --version
nginx -v



# b. CLONE LARAVEL PROJECT

# 1. Buat direktori untuk project
mkdir -p /var/www

# 2. Clone dari resource
cd /var/www
git clone https://github.com/sofronz/simple-rest-api.git laravel

cd /var/www/laravel

# 3. Install dependencies dengan Composer

curl -sS https://getcomposer.org/installer | php

composer install

# kl gabisa:

rm -f /usr/local/bin/composer
mv /var/www/laravel/composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
composer --version
cd /var/www/laravel
composer install


# 4. Setup permissions
chown -R www-data:www-data /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 777 /var/www/laravel/storage
chmod -R 777 /var/www/laravel/bootstrap/cache

# 5. Copy .env file
cp .env.example .env

# 6. Generate application key
php artisan key:generate

# 7. Setup database di .env secara otomatis
# Database di Palantir (10.69.4.2)
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=10.69.4.2/' /var/www/laravel/.env
sed -i 's/DB_DATABASE=laravel/DB_DATABASE=K11_db/' /var/www/laravel/.env
sed -i 's/DB_USERNAME=root/DB_USERNAME=K11_user/' /var/www/laravel/.env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=K11_password/' /var/www/laravel/.env


nano /var/www/laravel/.env
# DB_HOST=10.69.4.2
# DB_DATABASE=K11_db
# DB_USERNAME=K11_user
# DB_PASSWORD=K11_password

# c. KONFIGURASI NGINX untuk Laravel


# Buat config nginx

# UNTUK ELENDIL (10.69.1.2):
cat > /etc/nginx/sites-available/laravel << 'EOF'
server {
    listen 80;
    server_name elendil.K11.com 10.69.1.2;

    root /var/www/laravel/public;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log /var/log/nginx/laravel_error.log;
    access_log /var/log/nginx/laravel_access.log;
}
EOF

# --- ULANGI UNTUK ISILDUR (10.69.1.3) ---
# Ubah server_name: isildur.K11.com 10.69.1.3

# --- ULANGI UNTUK ANARION (10.69.1.4) ---
# Ubah server_name: anarion.K11.com 10.69.1.4

# 1. Enable site
ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# 2. Test nginx config
nginx -t

# 3. Restart services
service php8.4-fpm restart
service nginx restart

# Ulangi untuk Isildur & Anarion (ganti server_name dan IP sesuai node)


# d. TEST LARAVEL WORKERS
# TEST dari CLIENT (Miriel, Celebrimbor, dll)

# 1. Install lynx di client
apt-get update
apt-get install -y lynx

# 2. Test akses ke Laravel workers
lynx http://elendil.K11.com
lynx http://isildur.K11.com
lynx http://anarion.K11.com

# 3. Test dengan curl
curl http://elendil.K11.com
curl http://isildur.K11.com
