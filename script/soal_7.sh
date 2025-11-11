# 1. ELENDIL

# --- 1. Instalasi Paket yang Dibutuhkan ---
apt-get update

# Install paket prasyarat untuk menambah repositori PHP
apt-get install -y lsb-release apt-transport-https ca-certificates wget

# Tambahkan GPG key dan repositori Sury untuk PHP 8.4
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt-get update

# Install semua kebutuhan
apt-get install -y php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql php8.4-cli php8.4-common php8.4-intl nginx git composer

# --- 2. Unduh dan Siapkan Aplikasi Laravel ---
# Pindah ke direktori web server
cd /var/www

# Unduh kode aplikasi dari GitHub 
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git

# Masuk ke direktori proyek
cd laravel-simple-rest-api

# Install semua dependensi PHP dengan Composer
composer install 
composer update

# Buat file environment dari contoh yang ada
cp .env.example .env

# Buat kunci enkripsi aplikasi
php artisan key:generate



# --- 3. Konfigurasi Nginx ---
# Buat file konfigurasi server block untuk Laravel
cat <<EOF > /etc/nginx/sites-available/laravel
server {
   # diubah sesuai node
    # Elendil: 8001
    # Isildur: 8002
    # Anarion: 8003
    listen 8001;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;
    server_name _;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        # Pastikan ini menunjuk ke versi PHP yang benar
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# --- 4. Finalisasi dan Jalankan Layanan ---
# symbolic link
ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/

# Hapus konfigurasi default agar tidak bentrok
rm /etc/nginx/sites-enabled/default

# Berikan izin akses folder 'storage' Laravel kepada web server
chown -R www-data:www-data /var/www/laravel-simple-rest-api/storage

# Mulai service PHP-FPM dan restart Nginx
service php8.4-fpm start
service nginx restart

# revisi

# 1. Masuk ke direktori aplikasi
cd /var/www/laravel-simple-rest-api

# 2. update
composer update

# 3.'key:generate' 
php artisan key:generate






# 2. ISILDUR: 
# --- 1. Instalasi Paket yang Dibutuhkan ---
apt-get update

# Install paket prasyarat untuk menambah repositori PHP
apt-get install -y lsb-release apt-transport-https ca-certificates wget

# Tambahkan GPG key dan repositori Sury untuk PHP 8.4
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt-get update

# Install semua kebutuhan
apt-get install -y php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql php8.4-cli php8.4-common php8.4-intl nginx git composer

# --- 2. Unduh dan Siapkan Aplikasi Laravel ---
# Pindah ke direktori web server
cd /var/www

# Unduh kode aplikasi dari GitHub
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git

# Masuk ke direktori proyek
cd laravel-simple-rest-api

# Install semua dependensi PHP dengan Composer
composer install

composer update

# Buat file environment dari contoh yang ada
cp .env.example .env

# Buat kunci enkripsi aplikasi
php artisan key:generate

# --- 3. Konfigurasi Nginx ---
# Buat file konfigurasi server block untuk Laravel

cat <<EOF > /etc/nginx/sites-available/laravel
server {
    # ubah sesuai port
    # Elendil: 8001
    # Isildur: 8002
    # Anarion: 8003
    listen 8002;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;
    server_name _;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        # Pastikan ini menunjuk ke versi PHP yang benar
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# --- 4. Finalisasi dan Jalankan Layanan ---
ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/

# Hapus konfigurasi default (g bentrok)
rm /etc/nginx/sites-enabled/default

# Berikan izin akses folder 'storage' Laravel kepada web server
chown -R www-data:www-data /var/www/laravel-simple-rest-api/storage

# Mulai service PHP-FPM dan restart Nginx
service php8.4-fpm start
service nginx restart

# revisi

# 1. Masuk ke direktori aplikasi
cd /var/www/laravel-simple-rest-api

# 2. update
composer update

# 3. key generate
php artisan key:generate



# 3. ANARION
# --- 1. Instalasi Paket yang Dibutuhkan ---
apt-get update

# Install paket prasyarat untuk menambah repositori PHP
apt-get install -y lsb-release apt-transport-https ca-certificates wget

# Tambahkan GPG key dan repositori Sury untuk PHP 8.4
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt-get update

# Install semua kebutuhan
apt-get install -y php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql php8.4-cli php8.4-common php8.4-intl nginx git composer

# --- 2. Unduh dan Siapkan Aplikasi Laravel ---
# Pindah ke direktori web server
cd /var/www

# Unduh kode aplikasi dari GitHub (Resource-laravel)
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git

# Masuk ke direktori proyek
cd laravel-simple-rest-api

# Install semua dependensi PHP dengan Composer
composer install

# Buat file environment dari contoh yang ada
cp .env.example .env

# Buat kunci enkripsi aplikasi
php artisan key:generate

# --- 3. Konfigurasi Nginx ---
# Buat file konfigurasi server block untuk Laravel
cat <<EOF > /etc/nginx/sites-available/laravel
server {
    # !ubah sesuai node
    # Elendil: 8001
    # Isildur: 8002
    # Anarion: 8003
    listen 8003;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;
    server_name _;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        # Pastikan ini menunjuk ke versi PHP yang benar
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# --- 4. Finalisasi dan Jalankan Layanan ---
# symbolic link
ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/

# Hapus konfigurasi default agar tidak bentrok
rm /etc/nginx/sites-enabled/default

# Berikan izin akses folder 'storage' Laravel kepada web server
chown -R www-data:www-data /var/www/laravel-simple-rest-api/storage

# Mulai service PHP-FPM dan restart Nginx
service php8.4-fpm start
service nginx restart


# revisi

# 1. Masuk ke direktori aplikasi
cd /var/www/laravel-simple-rest-api

# 2. update
composer update

# 3. key generate
php artisan key:generate

# TEST LARAVEL WORKERS
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

lynx http://10.69.1.2

lynx http://10.69.1.2:8001
lynx http://10.69.1.3:8002
lynx http://10.69.1.4:8003