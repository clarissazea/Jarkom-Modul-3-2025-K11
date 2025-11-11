
# a. ERENDIS

cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
nameserver 10.69.3.2
nameserver 10.69.3.3
EOF

# 1. update zone file dengan CNAME, PTR, dan TXT records

cat > soal_5.sh << EOFS
#!/bin/bash
cat > /etc/bind/jarkom/K11.com << 'EOF'
\$TTL    604800
@    IN   SOA   K11.com. root.K11.com. (
                              2024110204    ; Serial (INCREMENT!)
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

; A records untuk domain utama
@           IN      A       10.69.3.2    ; 

; CNAME - Alias www
www         IN      A       10.69.3.2    ; www.K11.com → K11.com

; A records untuk semua lokasi penting
palantir    IN      A       10.69.4.2
elros       IN      A       10.69.1.6
pharazon    IN      A       10.69.2.6
elendil     IN      A       10.69.1.2
isildur     IN      A       10.69.1.3
anarion     IN      A       10.69.1.4
galadriel   IN      A       10.69.2.2
celeborn    IN      A       10.69.2.3
oropher     IN      A       10.69.2.4

; TXT Records - Pesan Rahasia
Cincin-Sauron       IN      TXT     "Lokasi: elros.K11.com (10.69.1.6)"
Aliansi-Terakhir    IN      TXT     "Lokasi: pharazon.K11.com (10.69.2.6)"
EOF



# 2. restart BIND9
service bind9 restart

EOFS

# 3. Test CNAME
nslookup www.K11.com

# 4. Test TXT records
dig Cincin-Sauron.K11.com TXT @10.69.3.2
dig Aliansi-Terakhir.K11.com TXT @10.69.3.2


# b. ERENDIS (setup reverse DNS)

cat > soal_5.sh << EOFS
#!/bin/bash
# 1. Tambahkan reverse zone untuk subnet 10.69.3.0/24 (Erendis)
cat >> /etc/bind/named.conf.local << 'EOF'

// Reverse zone untuk 10.69.3.0/24
zone "3.69.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.69.10.in-addr.arpa";
    allow-transfer { 10.69.3.3; };
};
EOF

# 2. Buat reverse zone file untuk 10.69.3.0/24
cat > /etc/bind/jarkom/3.69.10.in-addr.arpa << 'EOF'
;
; Reverse DNS zone for 10.69.3.0/24
;
$TTL    604800
@       IN      SOA     K11.com. root.K11.com. (
                              2024110201    ; Serial
                              604800        ; Refresh
                              86400         ; Retry
                              2419200       ; Expire
                              604800 )      ; Negative Cache TTL
;
@       IN      NS      ns1.K11.com.
@       IN      NS      ns2.K11.com.

; PTR Records
2       IN      PTR     ns1.K11.com.     ; 10.69.3.2 → ns1.K11.com (Erendis)
3       IN      PTR     ns2.K11.com.     ; 10.69.3.3 → ns2.K11.com (Amdir)
EOF

# 3. Tambahkan reverse zone untuk subnet 10.69.4.0/24 (Amdir)
cat >> /etc/bind/named.conf.local << 'EOF'

// Reverse zone untuk 10.69.4.0/24
zone "4.69.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/4.69.10.in-addr.arpa";
    allow-transfer { 10.69.3.3; };
};
EOF

# 4. Buat reverse zone file untuk 10.69.4.0/24
cat > /etc/bind/jarkom/4.69.10.in-addr.arpa << 'EOF'
;
; Reverse DNS zone for 10.69.4.0/24
;
$TTL    604800
@       IN      SOA     K11.com. root.K11.com. (
                              2024110201    ; Serial
                              604800        ; Refresh
                              86400         ; Retry
                              2419200       ; Expire
                              604800 )      ; Negative Cache TTL
;
@       IN      NS      ns1.K11.com.
@       IN      NS      ns2.K11.com.

; PTR Records
2       IN      PTR     palantir.K11.com.     ; 10.69.4.2 (Palantir)
EOF

# 5. Restart BIND9
service bind9 restart

EOFS

# 6. Cek syntax
named-checkconf
named-checkzone K11.com /etc/bind/jarkom/K11.com
named-checkzone 3.69.10.in-addr.arpa /etc/bind/jarkom/3.69.10.in-addr.arpa
named-checkzone 4.69.10.in-addr.arpa /etc/bind/jarkom/4.69.10.in-addr.arpa

# 7. Test PTR

# Uji PTR untuk Erendis (10.69.3.2)
dig -x 10.69.3.2 @10.69.3.2

# Uji PTR untuk Amdir (10.69.3.3)
dig -x 10.69.3.3 @10.69.3.2

# Uji PTR untuk Palantir (10.69.4.2)
dig -x 10.69.4.2 @10.69.3.2


#c. AMDIR (menerima semua perubahan)

# 1. Tambahkan reverse zones di slave
cat >> /etc/bind/named.conf.local << 'EOF'

// Reverse zone untuk 10.69.3.0/24 (Slave)
zone "3.69.10.in-addr.arpa" {
    type slave;
    masters { 10.69.3.2; };
    file "/var/lib/bind/3.69.10.in-addr.arpa";
    allow-notify { 10.69.3.2; };
};

// Reverse zone untuk 10.69.4.0/24 (Slave)
zone "4.69.10.in-addr.arpa" {
    type slave;
    masters { 10.69.3.2; };
    file "/var/lib/bind/4.69.10.in-addr.arpa";
    allow-notify { 10.69.3.2; };
};
EOF

# 2. Restart BIND9
service bind9 restart

# 3. Cek transfer
ls -la /var/lib/bind/

# 4. Test

# Uji CNAME (Alias www)
dig www.K11.com 

# Uji TXT Records
dig Cincin-Sauron.K11.com TXT @127.0.0.1

# Uji PTR Erendis
dig -x 10.69.3.2 @127.0.0.1

dig elros.K11.com
dig pharazon.K11.com