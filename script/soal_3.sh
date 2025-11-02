
# a. MINATSIR (IP: 10.69.5.2)

# 1. Update dan nstall bind9
apt-get update
apt-get install bind9 bind9utils dnsutils -y

# 2. Backup konfigurasi 
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup

# 3. Konfigurasi DNS Forwarder
cat > /etc/bind/named.conf.options << 'EOF'
options {
    directory "/var/cache/bind";
    
    # Forwarder ke Valinor/Internet (192.168.122.1)
    forwarders {
        192.168.122.1;
    };
    
    # Allow query dari semua network internal
    allow-query { any; };
    
    # Recursion harus enabled untuk forwarder
    recursion yes;
    
    # Listen pada semua interface
    listen-on { any; };
    
    # Disable IPv6 jika tidak dipakai
    listen-on-v6 { none; };
    
    # Tidak authoritative untuk domain apapun
    auth-nxdomain no;
    
    # DNSSEC validation
    dnssec-validation auto;
    
    # Allow transfer untuk DNS Slave (Amdir)
    allow-transfer { 10.69.4.5; };
};
EOF

# 4. Restart 
service bind9 restart

service bind9 status

# 5. Test DNS dari minatsir sendiri
nslookup google.com 127.0.0.1
dig google.com @127.0.0.1



# b. Jalankan ini di setiap node (ganti nameservernya)
cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
EOF

# c. Test di Elendil

# 1. Cek nameserver
cat /etc/resolv.conf
# Output: nameserver 10.69.5.2

# 2. Test nslookup
nslookup google.com
# Server: 10.69.5.2
# Address: 10.69.5.2#53

# 3. Test dig
dig google.com

# 4. Test ping domain
ping -c 3 google.com

# d. Test di Gilgalad/Amandil/Khamul
# Setelah dapat IP dari DHCP, cek:
cat /etc/resolv.conf
# Harus ada: nameserver 10.69.5.2
