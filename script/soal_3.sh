
# a. MINATSIR (IP: 10.69.5.2)

cat > soal_3.sh << EOFS
#!/bin/bash
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
        10.69.3.2;
        10.69.3.3;
        192.168.122.1;

    };
    forward only;

    # DNSSEC validation
    dnssec-validation no;

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
    
};
EOF

cat > /etc/bind/named.conf.local << 'EOF'

zone "K11.com" {
    type forward;
    forward only;
    forwarders {
        10.69.3.2;  
        10.69.3.3;
        192.168.122.1;
        };
};
EOF

# 4. Restart 
ln -s /etc/init.d/named /etc/init.d/bind9

service bind9 start

EOFS


service bind9 status

# 5. Test DNS dari minatsir sendiri
dig google.com @127.0.0.1



# b. Jalankan ini di setiap node (ganti nameservernya kecuali durin & minatsir) (Elendil, Isildur, Anarion, Galadriel, Celeborn, dll)

cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
EOF




# c. Test di Elendil

# 1. Cek nameserver
cat /etc/resolv.conf
# Output: nameserver 10.69.5.2

# 2. Test dig
dig google.com

# 3. Test ping domain
ping -c 3 google.com




# d. Test di Gilgalad/Amandil/Khamul
# Setelah dapat IP dari DHCP, cek:
cat /etc/resolv.conf
# Harus ada: nameserver 10.69.5.2
