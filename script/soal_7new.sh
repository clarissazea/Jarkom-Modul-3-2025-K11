cat > soal_7.sh << EOFS
#!/bin/bash

cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
nameserver 10.69.3.2
nameserver 10.69.3.3
EOF


apt update
apt install -y lsb-release apt-transport-https ca-certificates wget
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

apt update
apt install php8.4-mbstring php8.4-xml php8.4-cli php8.4-common php8.4-intl php8.4-opcache php8.4-readline php8.4-mysql php8.4-fpm php8.4-curl unzip wget -y
apt install nginx -y
wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

apt install git -y
cd /var/www/
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git
cd laravel-simple-rest-api
composer install

EOFS