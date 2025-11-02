
# PALANTIR (10.69.4.2)

# 1. Install MariaDB
apt-get update
apt-get install -y mariadb-server

# 2. Start MariaDB
service mysql start

# 3. Konfigurasi MariaDB untuk allow remote connection
cat > /etc/mysql/mariadb.conf.d/50-server.cnf << 'EOF'
[server]
[mysqld]
user                    = mysql
pid-file                = /run/mysqld/mysqld.pid
basedir                 = /usr
datadir                 = /var/lib/mysql
tmpdir                  = /tmp
lc-messages-dir         = /usr/share/mysql
lc-messages             = en_US
skip-external-locking

# Bind to all interfaces
bind-address            = 0.0.0.0

port                    = 3306
max_connections         = 100
connect_timeout         = 5
wait_timeout            = 600
max_allowed_packet      = 64M
thread_cache_size       = 128
sort_buffer_size        = 4M
bulk_insert_buffer_size = 16M
tmp_table_size          = 32M
max_heap_table_size     = 32M

myisam_recover_options  = BACKUP
key_buffer_size         = 128M
table_open_cache        = 400
myisam_sort_buffer_size = 512M
concurrent_insert       = 2
read_buffer_size        = 2M
read_rnd_buffer_size    = 1M

query_cache_limit       = 128K
query_cache_size        = 64M

log_error = /var/log/mysql/error.log

expire_logs_days        = 10

character-set-server    = utf8mb4
collation-server        = utf8mb4_general_ci

[embedded]
[mariadb]
[mariadb-10.5]
EOF

# 4. Restart MySQL
service mysql restart

# 5. Setup database dan user untuk Laravel
mysql -e "CREATE DATABASE IF NOT EXISTS K11_laravel;"
mysql -e "CREATE USER IF NOT EXISTS 'K11_user'@'%' IDENTIFIED BY 'K11_password';"
mysql -e "GRANT ALL PRIVILEGES ON K11_laravel.* TO 'K11_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# 6. Verifikasi
mysql -e "SHOW DATABASES;"
mysql -e "SELECT User, Host FROM mysql.user;"

