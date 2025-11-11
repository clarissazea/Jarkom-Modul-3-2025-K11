

# ============================================
# STEP 0: PALANTIR - DATABASE SERVER
# ============================================

cat << 'PALANTIR_SCRIPT'
echo "=== Setting up Palantir Database Server ==="

# Install MariaDB
apt-get update
apt-get install -y mariadb-server

# Configure MySQL untuk allow remote connections
cat > /etc/mysql/mariadb.conf.d/50-server.cnf << 'EOF'
[server]
[mysqld]
user = mysql
pid-file = /run/mysqld/mysqld.pid
basedir = /usr
datadir = /var/lib/mysql
tmpdir = /tmp
bind-address = 0.0.0.0
port = 3306
max_connections = 100
EOF

# Restart MySQL
service mysql restart

# Create database and user
mysql << 'DBSQL'
CREATE DATABASE IF NOT EXISTS K11_laravel;
CREATE USER IF NOT EXISTS 'K11_user'@'%' IDENTIFIED BY 'K11_password';
GRANT ALL PRIVILEGES ON K11_laravel.* TO 'K11_user'@'%';
FLUSH PRIVILEGES;
SHOW DATABASES;
SELECT User, Host FROM mysql.user WHERE User='K11_user';
DBSQL

echo ""
echo "=== Palantir Database Ready! ==="
echo "Database: K11_laravel"
echo "User: K11_user"
echo "Password: K11_password"
echo "Host: 10.69.4.2:3306"
PALANTIR_SCRIPT

# ============================================
# STEP 1: ELENDIL - Laravel Worker Port 8001
# ============================================

cat << 'ELENDIL_SCRIPT'
echo "=== Setting up Elendil - Port 8001 ==="

# 1. Update & Install Dependencies
apt-get update
apt-get install -y lsb-release apt-transport-https ca-certificates wget

# 2. Add PHP 8.4 Repository
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt-get update

# 3. Install PHP 8.4, Nginx, Git, Composer
apt-get install -y php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql \
    php8.4-cli php8.4-common php8.4-intl nginx git composer

# 4. Clone Laravel Project
cd /var/www
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git
cd laravel-simple-rest-api

# 5. Install Composer Dependencies
composer install
composer update

# 6. Setup Laravel
cp .env.example .env
php artisan key:generate

# 7. === SOAL 8: Configure Database Connection ===
echo "Configuring database connection to Palantir..."
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=10.69.4.2/' .env
sed -i 's/DB_DATABASE=laravel/DB_DATABASE=K11_laravel/' .env
sed -i 's/DB_USERNAME=root/DB_USERNAME=K11_user/' .env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=K11_password/' .env

# Clear cache
php artisan config:clear
php artisan cache:clear

# 8. === SOAL 8: Configure Nginx - Port 8001 & Block IP ===
cat > /etc/nginx/sites-available/laravel << 'EOF'
server {
    listen 8001;
    server_name elendil.K11.com;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;

    # Block IP access - only allow domain
    if ($host != "elendil.K11.com") {
        return 444;
    }

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

    access_log /var/log/nginx/laravel_access.log;
    error_log /var/log/nginx/laravel_error.log;
}
EOF

# 9. Enable Site
ln -sf /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# 10. Set Permissions
chown -R www-data:www-data /var/www/laravel-simple-rest-api/storage
chown -R www-data:www-data /var/www/laravel-simple-rest-api/bootstrap/cache
chmod -R 775 /var/www/laravel-simple-rest-api/storage
chmod -R 775 /var/www/laravel-simple-rest-api/bootstrap/cache

# 11. Start Services
service php8.4-fpm start
service nginx restart

# Wait a bit
sleep 2

# 12. === SOAL 8: Migration & Seeding (ELENDIL ONLY) ===
echo ""
echo "=== Running Migration & Seeding ==="
cd /var/www/laravel-simple-rest-api

# Test database connection
php artisan migrate:status

# Run migration and seeding
php artisan migrate:fresh --seed

echo ""
echo "=== Elendil Setup Complete! ==="
echo "Port: 8001"
echo "Domain: elendil.K11.com"
echo "Database: Connected to Palantir (10.69.4.2)"
echo "Migration: Done"
echo ""
echo "Test locally: curl http://localhost:8001"
ELENDIL_SCRIPT

# ============================================
# STEP 2: ISILDUR - Laravel Worker Port 8002
# ============================================

cat << 'ISILDUR_SCRIPT'
echo "=== Setting up Isildur - Port 8002 ==="

# 1. Update & Install Dependencies
apt-get update
apt-get install -y lsb-release apt-transport-https ca-certificates wget

# 2. Add PHP 8.4 Repository
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt-get update

# 3. Install PHP 8.4, Nginx, Git, Composer
apt-get install -y php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql \
    php8.4-cli php8.4-common php8.4-intl nginx git composer

# 4. Clone Laravel Project
cd /var/www
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git
cd laravel-simple-rest-api

# 5. Install Composer Dependencies
composer install
composer update

# 6. Setup Laravel
cp .env.example .env
php artisan key:generate

# 7. === SOAL 8: Configure Database Connection ===
echo "Configuring database connection to Palantir..."
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=10.69.4.2/' .env
sed -i 's/DB_DATABASE=laravel/DB_DATABASE=K11_laravel/' .env
sed -i 's/DB_USERNAME=root/DB_USERNAME=K11_user/' .env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=K11_password/' .env

php artisan config:clear
php artisan cache:clear

# 8. === SOAL 8: Configure Nginx - Port 8002 & Block IP ===
cat > /etc/nginx/sites-available/laravel << 'EOF'
server {
    listen 8002;
    server_name isildur.K11.com;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;

    # Block IP access - only allow domain
    if ($host != "isildur.K11.com") {
        return 444;
    }

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

    access_log /var/log/nginx/laravel_access.log;
    error_log /var/log/nginx/laravel_error.log;
}
EOF

# 9. Enable Site
ln -sf /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# 10. Set Permissions
chown -R www-data:www-data /var/www/laravel-simple-rest-api/storage
chown -R www-data:www-data /var/www/laravel-simple-rest-api/bootstrap/cache
chmod -R 775 /var/www/laravel-simple-rest-api/storage
chmod -R 775 /var/www/laravel-simple-rest-api/bootstrap/cache

# 11. Start Services
service php8.4-fpm start
service nginx restart

echo ""
echo "=== Isildur Setup Complete! ==="
echo "Port: 8002"
echo "Domain: isildur.K11.com"
echo "Database: Connected to Palantir (10.69.4.2)"
echo ""
echo "Test locally: curl http://localhost:8002"
ISILDUR_SCRIPT

# ============================================
# STEP 3: ANARION - Laravel Worker Port 8003
# ============================================

cat << 'ANARION_SCRIPT'
echo "=== Setting up Anarion - Port 8003 ==="

# 1. Update & Install Dependencies
apt-get update
apt-get install -y lsb-release apt-transport-https ca-certificates wget

# 2. Add PHP 8.4 Repository
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt-get update

# 3. Install PHP 8.4, Nginx, Git, Composer
apt-get install -y php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql \
    php8.4-cli php8.4-common php8.4-intl nginx git composer

# 4. Clone Laravel Project
cd /var/www
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git
cd laravel-simple-rest-api

# 5. Install Composer Dependencies
composer install
composer update

# 6. Setup Laravel
cp .env.example .env
php artisan key:generate

# 7. === SOAL 8: Configure Database Connection ===
echo "Configuring database connection to Palantir..."
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=10.69.4.2/' .env
sed -i 's/DB_DATABASE=laravel/DB_DATABASE=K11_laravel/' .env
sed -i 's/DB_USERNAME=root/DB_USERNAME=K11_user/' .env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=K11_password/' .env

php artisan config:clear
php artisan cache:clear

# 8. === SOAL 8: Configure Nginx - Port 8003 & Block IP ===
cat > /etc/nginx/sites-available/laravel << 'EOF'
server {
    listen 8003;
    server_name anarion.K11.com;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;

    # Block IP access - only allow domain
    if ($host != "anarion.K11.com") {
        return 444;
    }

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

    access_log /var/log/nginx/laravel_access.log;
    error_log /var/log/nginx/laravel_error.log;
}
EOF

# 9. Enable Site
ln -sf /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# 10. Set Permissions
chown -R www-data:www-data /var/www/laravel-simple-rest-api/storage
chown -R www-data:www-data /var/www/laravel-simple-rest-api/bootstrap/cache
chmod -R 775 /var/www/laravel-simple-rest-api/storage
chmod -R 775 /var/www/laravel-simple-rest-api/bootstrap/cache

# 11. Start Services
service php8.4-fpm start
service nginx restart

echo ""
echo "=== Anarion Setup Complete! ==="
echo "Port: 8003"
echo "Domain: anarion.K11.com"
echo "Database: Connected to Palantir (10.69.4.2)"
echo ""
echo "Test locally: curl http://localhost:8003"
ANARION_SCRIPT

# ============================================
# STEP 4: ELROS - LOAD BALANCER (SOAL 10)
# ============================================

cat << 'ELROS_SCRIPT'
echo "=== Setting up Elros - Load Balancer ==="

# 1. Install Nginx
apt-get update
apt-get install -y nginx

# 2. === SOAL 10: Configure Load Balancer ===
cat > /etc/nginx/sites-available/load-balancer << 'EOF'
# Upstream backend - Kesatria Numenor
upstream kesatria_numenor {
    # Round Robin algorithm (default)
    server elendil.K11.com:8001;
    server isildur.K11.com:8002;
    server anarion.K11.com:8003;
}

server {
    listen 80;
    server_name elros.K11.com;

    location / {
        proxy_pass http://kesatria_numenor;
        
        # Proxy headers
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Proxy timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    # Health check endpoint
    location /health {
        access_log off;
        return 200 "Elros Load Balancer is healthy\n";
        add_header Content-Type text/plain;
    }

    access_log /var/log/nginx/elros_access.log;
    error_log /var/log/nginx/elros_error.log;
}
EOF

# 3. Enable Site
ln -sf /etc/nginx/sites-available/load-balancer /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# 4. Test & Restart
nginx -t
service nginx restart

echo ""
echo "=== Elros Load Balancer Setup Complete! ==="
echo "Domain: elros.K11.com"
echo "Algorithm: Round Robin"
echo "Backends:"
echo "  - elendil.K11.com:8001"
echo "  - isildur.K11.com:8002"
echo "  - anarion.K11.com:8003"
echo ""
echo "Test: curl http://elros.K11.com"
ELROS_SCRIPT

# ============================================
# STEP 5: TESTING FROM CLIENT (SOAL 9)
# JALANKAN DI CLIENT (Miriel/Celebrimbor)
# ============================================

cat << 'CLIENT_SCRIPT'
echo "=== Testing from Client - Soal 9 ==="

# Install lynx and curl
apt-get update
apt-get install -y lynx curl

echo ""
echo "=== TEST 1: DNS Resolution ==="
nslookup elendil.K11.com
nslookup isildur.K11.com
nslookup anarion.K11.com
nslookup elros.K11.com

echo ""
echo "=== TEST 2: Test dengan lynx (halaman utama) ==="
echo "Testing Elendil..."
lynx -dump http://elendil.K11.com:8001 | head -20

echo ""
echo "Testing Isildur..."
lynx -dump http://isildur.K11.com:8002 | head -20

echo ""
echo "Testing Anarion..."
lynx -dump http://anarion.K11.com:8003 | head -20

echo ""
echo "=== TEST 3: Test API /api/airing ==="
echo "Elendil API:"
curl http://elendil.K11.com:8001/api/airing

echo ""
echo "Isildur API:"
curl http://isildur.K11.com:8002/api/airing

echo ""
echo "Anarion API:"
curl http://anarion.K11.com:8003/api/airing

echo ""
echo "=== TEST 4: Test IP Access (should be blocked) ==="
echo "Testing IP access to Elendil (should fail):"
curl -v http://10.69.1.2:8001 2>&1 | head -10

echo ""
echo "=== TEST 5: Test Load Balancer ==="
echo "Testing Elros Load Balancer:"
for i in {1..6}; do
    echo "Request $i:"
    curl -s http://elros.K11.com | head -1
    sleep 1
done

echo ""
echo "Testing Elros API through load balancer:"
curl http://elros.K11.com/api/airing

echo ""
echo "=== All Tests Complete! ==="
CLIENT_SCRIPT

# ============================================
# VERIFICATION COMMANDS
# ============================================

cat << 'VERIFY'
========================================
VERIFICATION COMMANDS
========================================

# Di Palantir:
mysql -e "SHOW DATABASES LIKE 'K11_laravel';"
mysql -e "SELECT User, Host FROM mysql.user WHERE User='K11_user';"

# Di Workers (Elendil/Isildur/Anarion):
service nginx status
service php8.4-fpm status
ss -tlnp | grep 800[1-3]
curl http://localhost:800X

# Di Elros:
service nginx status
nginx -T | grep -A 5 upstream
curl http://localhost/health

# Di Client:
curl http://elendil.K11.com:8001
curl http://isildur.K11.com:8002
curl http://anarion.K11.com:8003
curl http://elros.K11.com
curl http://elros.K11.com/api/airing

========================================
VERIFY