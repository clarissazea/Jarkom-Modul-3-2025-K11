
# a. ERENDIS (10.69.3.2)

# jangan lupa ganti erendis dan amdir


cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
nameserver 10.69.3.2
nameserver 10.69.3.3
EOF


# 1. install 
apt-get update
apt-get install bind9 bind9utils dnsutils -y

# 2. konfigurasi named.conf.local
cat > /etc/bind/named.conf.local << 'EOF'
// Zone untuk K11.com (Master)
zone "K11.com" {
    type master;
    file "/etc/bind/jarkom/K11.com";
    allow-transfer { 10.69.3.3; }; // IP Amdir (Slave)
    notify yes;
};
EOF

# 3. bikin directory untuk zone files
mkdir -p /etc/bind/jarkom

# 4. bikin zone file K11.com
cat > /etc/bind/jarkom/K11.com << 'EOF'

; BIND data file for K11.com

$TTL    604800
@       IN      SOA     K11.com. root.K11.com. (
                              2024110201    ; Serial (YYYYMMDDNN)
                              604800        ; Refresh
                              86400         ; Retry
                              2419200       ; Expire
                              604800 )      ; Negative Cache TTL
;
; Name servers
@           IN      NS      ns1.K11.com.
@           IN      NS      ns2.K11.com.

; A records untuk name servers
ns1         IN      A       10.69.3.2    ; Erendis
ns2         IN      A       10.69.3.3    ; Amdir

; A records untuk semua lokasi penting
palantir    IN      A       10.69.4.2    ; Database Server
elros       IN      A       10.69.1.6    ; Load Balancer Laravel
pharazon    IN      A       10.69.2.6    ; Load Balancer PHP
elendil     IN      A       10.69.1.2    ; Laravel Worker-1
isildur     IN      A       10.69.1.3    ; Laravel Worker-2
anarion     IN      A       10.69.1.4    ; Laravel Worker-3
galadriel   IN      A       10.69.2.2    ; PHP Worker-1
celeborn    IN      A       10.69.2.3    ; PHP Worker-2
oropher     IN      A       10.69.2.4    ; PHP Worker-3
EOF

# 5. konfigurasi options
cat > /etc/bind/named.conf.options << 'EOF'
options {
    directory "/var/cache/bind";
    
    # Forwarder ke Minastir
    forwarders {
        10.69.5.2;
    };
    
    allow-query { any; };
    allow-transfer { 10.69.3.3; }; // Amdir
    recursion yes;
    listen-on-v6 { none; };
    dnssec-validation auto;
};
EOF



# 7. restart
ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 start

# 6. cek syntax konfigurasi
named-checkconf
named-checkzone K11.com /etc/bind/jarkom/K11.com

# 8. test
# nslookup palantir.K11.com 127.0.0.1
# nslookup elros.K11.com 127.0.0.1



# b. AMDIR (10.69.3.3)
# langkah sama kaya di ERENDIS, tapi ini buat SLAVE DNS



cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
nameserver 10.69.3.2
nameserver 10.69.3.3
EOF

# 1. install bind9
apt-get update
apt-get install bind9 bind9utils dnsutils -y

# 2. konfigurasi named.conf.local 
cat > /etc/bind/named.conf.local << 'EOF'
// Zone untuk K11.com (Slave)
zone "K11.com" {
    type slave;
    masters { 10.69.3.2; }; // IP Erendis (Master)
    file "/var/lib/bind/K11.com";
    allow-notify { 10.69.3.2; };
};
EOF

# 3. konfigurasi options
cat > /etc/bind/named.conf.options << 'EOF'
options {
    directory "/var/cache/bind";
    
    # Forwarder ke Minastir
    forwarders {
        10.69.5.2;
    };
    
    allow-query { any; };
    recursion yes;
    listen-on-v6 { none; };
    dnssec-validation auto;
};
EOF

# 4. restart BIND9
ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart


# 5. cek syntaxnya
named-checkconf


# 6. cek zone transfer
ls -la /var/lib/bind/
cat /var/lib/bind/K11.com




# c. Test dari client (Elendil, Miriel, dll)

# jangan lupa ganti client
cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
nameserver 10.69.3.2
nameserver 10.69.3.3
EOF

# 1. Test query ke Erendis (Master)
ping isildur.K11.com


ping palantir.K11.com
dig palantir.K11.com 


# kl gabisa
masuk ke /etc/hosts
tambahin: 

ip 10.69.4.2 palantir.K11.com

# 3. Test semua A records
ping elros.K11.com
ping pharazon.K11.com
ping elendil.K11.com
ping galadriel.K11.com

dig elros.K11.com
dig pharazon.K11.com
dig elendil.K11.com
dig galadriel.K11.com

