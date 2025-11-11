# Jarkom-Modul-3-2025-K11

# The Last Alliance Gathers

Bayangan dari timur memanjang, lebih gelap dari malam tanpa bintang. Di Lindon, Gilgalad merasakan angin dingin yang tak biasa merayapi menaranya. Panji biru dan peraknya berkibar gelisah, seolah tahu badai api akan segera datang. Ia menggenggam tombaknya, Aeglos, merasakan tanggung jawab sebagai Raja Tertinggi menekan bahunya. Di selatan, Elendil, yang baru saja membangun kerajaannya dari puing-puing kenangan Númenor yang tenggelam, menatap ke arah Mordor. Pedangnya, Narsil, yang belum patah, berkilauan di sisinya, memantulkan tekad pahit seorang penyintas. Putra-putranya, Isildur dan Anarion, memeriksa baju zirah mereka di Osgiliath. Darah muda mendidih, namun mata mereka menyimpan bayangan laut yang menelan tanah air mereka. Di pegunungan yang menjulang, Durin di Khazad-dûm mendengar panggilan terompet perang. Kapak-kapak mulai diasah, dan gema langkah kaki para Kurcaci mengguncang akar gunung. Di Greenwood yang luas, Oropher mengumpulkan pasukan Silvan-nya. Hutan terasa menahan napas, daun-daun emasnya bergetar bukan karena angin. Di Eregion yang telah lama sunyi, Celebrimbor hanyalah nama dalam legenda, namun Tiga Cincin yang dibuatnya masih bersinar di jari-jari Galadriel dan Gilgalad, berdenyut dengan kewaspadaan. Galadriel dan Celeborn di Lórien merasakan kekuatan gelap mengumpul seperti awan badai. Bahkan para worker, Elendil, Isildur, Anárion, Galadriel, Celeborn, Oropher, merasakan energi yang berbeda mengalir melalui node mereka, sebuah perintah yang lebih besar sedang dijalankan. Para client, Miriel, Amandil, Gilgalad, Celebrimbor, menanti dengan cemas di balik benteng-benteng baru. Aldarion (DHCP Server) mulai mengalokasikan sumber daya terakhir, sementara Erendis (DNS Master) memastikan semua nama dan tujuan tercatat dengan benar sebelum kekacauan dimulai. Dan di Mordor, menara Barad-dûr menjulang, gelap dan mengancam, seolah mata tanpa kelopak sedang mengawasi mereka semua, menunggu. Zaman Kedua baru saja menarik napas terakhirnya sebelum terjun ke dalam api perang.

## Topologi

<img width="1202" height="818" alt="image" src="https://github.com/user-attachments/assets/72ee5a37-07be-4178-b7dc-cf78b6218256" />

## SOAL 1

Di awal Zaman Kedua, setelah kehancuran Beleriand, para Valar menugaskan untuk membangun kembali jaringan komunikasi antar kerajaan. Para Valar menyalakan Minastir, Aldarion, Erendis, Amdir, Palantir, Narvi, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher, Miriel, Amandil, Gilgalad, Celebrimbor, Khamul, dan pastikan setiap node (selain Durin sang penghubung antar dunia) dapat sementara berkomunikasi dengan Valinor/Internet (nameserver 192.168.122.1) untuk menerima instruksi awal.

## Script

```
# DURIN - Router & DHCP Relay

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.69.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.69.2.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.69.3.1
    netmask 255.255.255.0

auto eth4
iface eth4 inet static
    address 10.69.4.1
    netmask 255.255.255.0

auto eth5
iface eth5 inet static
    address 10.69.5.1
    netmask 255.255.255.0

# run ini
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.69.0.0/16

# ELENDIL - Laravel Worker-1 (10.69.1.2)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.1.2
    netmask 255.255.255.0
    gateway 10.69.1.1
    dns-nameservers 192.168.122.1

# ISILDUR - Laravel Worker-2 (10.69.1.3)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.1.3
    netmask 255.255.255.0
    gateway 10.69.1.1
    dns-nameservers 192.168.122.1

# ANARION - Laravel Worker-3 (10.69.1.4)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.1.4
    netmask 255.255.255.0
    gateway 10.69.1.1
    dns-nameservers 192.168.122.1


# MIRIEL - Client-Static-1 (10.69.1.5)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.1.5
    netmask 255.255.255.0
    gateway 10.69.1.1
    dns-nameservers 192.168.122.1


# ELROS - Load Balancer Laravel (10.69.1.6)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.1.6
    netmask 255.255.255.0
    gateway 10.69.1.1
    dns-nameservers 192.168.122.1


# AMANDIL - Client-Dynamic-2 (DHCP)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

SUBNET1

# GALADRIEL - PHP Worker-1 (10.69.2.2)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.2.2
    netmask 255.255.255.0
    gateway 10.69.2.1
    dns-nameservers 192.168.122.1


# CELEBORN - PHP Worker-2 (10.69.2.3)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.2.3
    netmask 255.255.255.0
    gateway 10.69.2.1
    dns-nameservers 192.168.122.1

# OROPHER - PHP Worker-3 (10.69.2.4)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.2.4
    netmask 255.255.255.0
    gateway 10.69.2.1
    dns-nameservers 192.168.122.1


# CELEBRIMBOR - Client-Static-2 (10.69.2.5)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.2.5
    netmask 255.255.255.0
    gateway 10.69.2.1
    dns-nameservers 192.168.122.1


# GILGALAD - Client-Dynamic-1 (DHCP)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp


# PHARAZON - Load Balancer PHP (10.69.4.6)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.2.6
    netmask 255.255.255.0
    gateway 10.69.2.1
    dns-nameservers 192.168.122.1

SUBNET2

# ERENDIS - DNS Master (10.69.3.2)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.3.2
    netmask 255.255.255.0
    gateway 10.69.3.1
    dns-nameservers 192.168.122.1

# KHAMUL - Client-Fixed-Address (10.69.3.95)
# Di Switch8 yang terhubung ke Switch3
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
hwaddress ether 02:00:00:00:00:01

SUBNET3

# PALANTIR - Database Server (10.69.4.2)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.4.2
    netmask 255.255.255.0
    gateway 10.69.4.1
    dns-nameservers 192.168.122.1

# NARVI - Database Slave (10.69.4.3)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.4.3
    netmask 255.255.255.0
    gateway 10.69.4.1
    dns-nameservers 192.168.122.1

# ALDARION - DHCP Server (10.69.4.4)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.4.4
    netmask 255.255.255.0
    gateway 10.69.4.1
    dns-nameservers 192.168.122.1

# AMDIR - DNS Slave (10.69.4.5)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.3.3
    netmask 255.255.255.0
    gateway 10.69.3.1
    dns-nameservers 192.168.122.1


SUBNET4

# MINASTIR - DNS Forwarder (10.69.5.2)
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.69.5.2
    netmask 255.255.255.0
    gateway 10.69.5.1
    dns-nameservers 192.168.122.1

```

<img width="1449" height="674" alt="image" src="https://github.com/user-attachments/assets/5b3c2dfb-4fc7-4e2f-bf5a-811004fed5c3" />

```
# Cek routing
ip route

# Cek NAT/iptables
iptables -t nat -L -v

# Cek IP forwarding
cat /proc/sys/net/ipv4/ip_forward
```

<img width="921" height="449" alt="image" src="https://github.com/user-attachments/assets/1d078445-edf9-4343-b72e-5833cf615e66" />


`ping Durin ke Palantir`

<img width="1095" height="336" alt="image" src="https://github.com/user-attachments/assets/5a3a0527-927f-4959-ae60-403e9180d611" />

`ping -c 2 google.com`
<img width="1322" height="245" alt="image" src="https://github.com/user-attachments/assets/aaf643f6-8a83-409f-963b-303d493c7d73" />

`ping isildur`
<img width="1390" height="317" alt="image" src="https://github.com/user-attachments/assets/e4383315-87e6-40da-b94a-10007b3508b0" />

`ping Anarion`
<img width="1339" height="314" alt="image" src="https://github.com/user-attachments/assets/3510de04-ab99-4647-9c57-3d63df8dce32" />

## SOAL 2

Raja Pelaut Aldarion, penguasa wilayah Númenor, memutuskan cara pembagian tanah client secara dinamis. Ia menetapkan:

Client Dinamis Keluarga Manusia: Mendapatkan tanah di rentang [prefix ip].1.6 - [prefix ip].1.34 dan [prefix ip].1.68 - [prefix ip].1.94.
Client Dinamis Keluarga Peri: Mendapatkan tanah di rentang [prefix ip].2.35 - [prefix ip].2.67 dan [prefix ip].2.96 - [prefix ip].2.121.
Khamul yang misterius: Diberikan tanah tetap di [prefix ip].3.95, agar keberadaannya selalu diketahui. Pastikan Durin dapat menyampaikan dekrit ini ke semua wilayah yang terhubung dengannya.

## Script

```
# a. ALDARION (IP: 10.69.4.4)

cat > soal_2.sh << EOFS
#!/bin/bash
# 1. update dan install DHCP Server
apt-get update
apt-get install isc-dhcp-server -y

# 2. konfigurasi interface DHCP
cat > /etc/default/isc-dhcp-server << 'EOF'
INTERFACESv4="eth0"
INTERFACESv6=""
EOF

# 3. backup konfigurasi 
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.backup

# 4. konfigurasi DHCP Server
cat > /etc/dhcp/dhcpd.conf << 'EOF'
# DHCP Server Configuration - K11 Aldarion
# Domain dan DNS
option domain-name "K11.com";
option domain-name-servers 10.69.5.2;  # Minastir DNS Forwarder

# Lease time
default-lease-time 600;
max-lease-time 7200;

# Authoritative
authoritative;

# Update style
ddns-update-style none;

# SUBNET 10.69.1.0/24 - Client Dinamis Keluarga Manusia
subnet 10.69.1.0 netmask 255.255.255.0 {
    # Range 1: 10.69.1.6 - 10.69.1.34
    range 10.69.1.6 10.69.1.34;
    
    # Range 2: 10.69.1.68 - 10.69.1.94
    range 10.69.1.68 10.69.1.94;
    
    option routers 10.69.1.1;
    option broadcast-address 10.69.1.255;
    option domain-name-servers 10.69.5.2;
    default-lease-time 600;
    max-lease-time 7200;
}

# SUBNET 10.69.2.0/24 - Client Dinamis Keluarga Peri
subnet 10.69.2.0 netmask 255.255.255.0 {
    # Range 1: 10.69.2.35 - 10.69.2.67
    range 10.69.2.35 10.69.2.67;
    
    # Range 2: 10.69.2.96 - 10.69.2.121
    range 10.69.2.96 10.69.2.121;
    
    option routers 10.69.2.1;
    option broadcast-address 10.69.2.255;
    option domain-name-servers 10.69.5.2;
    default-lease-time 600;
    max-lease-time 7200;
}

# SUBNET 10.69.3.0/24 - Subnet untuk Erendis & Khamul
subnet 10.69.3.0 netmask 255.255.255.0 {
    option routers 10.69.3.1;
    option domain-name-servers 10.69.5.2;
}

# SUBNET 10.69.4.0/24 - Subnet DHCP Server (Aldarion)
subnet 10.69.4.0 netmask 255.255.255.0 {
    option routers 10.69.4.1;
    option domain-name-servers 10.69.5.2;
}

# SUBNET 10.69.5.0/24 - Subnet Minatsir
subnet 10.69.5.0 netmask 255.255.255.0 {
    option routers 10.69.5.1;
    option domain-name-servers 10.69.5.2;
}

# FIXED ADDRESS - Khamul (10.69.3.95)
host Khamul {
    hardware ethernet 02:00:00:00:00:01;
    fixed-address 10.69.3.95;
    option routers 10.69.3.1;
    option domain-name-servers 10.69.5.2;
}
EOF

# 5. test konfigurasi syntax
dhcpd -t -cf /etc/dhcp/dhcpd.conf

# 6. restart DHCP Server
service isc-dhcp-server restart

EOFS

# 7. cek status
service isc-dhcp-server status






# b. DURIN

cat > soal_2.sh << EOFS
#!/bin/bash

# 1. Install DHCP Relay
apt-get update
apt-get install isc-dhcp-relay -y

# 2. Konfigurasi DHCP Relay
cat > /etc/default/isc-dhcp-relay << 'EOF'
# DHCP Relay Configuration for Durin
# IP Address DHCP Server (Aldarion)
SERVERS="10.69.4.4"

# Interface yang akan relay DHCP requests
# Semua interface kecuali eth0 (internet)
INTERFACES="eth1 eth2 eth3 eth4 eth5"

# Options kosong (default)
OPTIONS=""
EOF

# 3. Restart DHCP Relay
service isc-dhcp-relay restart

EOFS


# 4. Cek status
service isc-dhcp-relay status



# c. TESTING 

# 1. Gilgalad

# Cek IP yang didapat
ip a show eth0

# Harus dapat IP di range:
# - 10.69.2.35 - 10.69.2.67 ATAU
# - 10.69.2.96 - 10.69.2.121

# Cek DNS yang didapat
cat /etc/resolv.conf
# Harus ada: nameserver 10.69.5.2

# Test koneksi
ping -c 3 10.69.2.1   # Gateway
ping -c 3 10.69.4.4   # Aldarion (DHCP Server)

# 2. Amandil

ip a show eth0

# Harus dapat IP di range:
# - 10.69.1.6 - 10.69.1.34 ATAU
# - 10.69.1.68 - 10.69.1.94

cat /etc/resolv.conf
# Harus ada: nameserver 10.69.5.2

ping -c 3 10.69.1.1   # Gateway

# 3. Khamul

# MAC Address
ip link show eth0 | grep ether
# Harus: 02:00:00:00:00:01

# Cek IP
ip a show eth0

# HARUS dapat IP: 10.69.3.95 (FIXED!)

cat /etc/resolv.conf
# Harus ada: nameserver 10.69.5.2

ping -c 3 10.69.3.1   # Gateway
```

## Testing

- Testing Gilgalad
<img width="1656" height="155" alt="image" src="https://github.com/user-attachments/assets/a82c5065-0aad-495a-90e2-aeb8127454f7" />

<img width="714" height="89" alt="image" src="https://github.com/user-attachments/assets/24cfa4e9-141f-4cf2-a3eb-7dcf2d0316db" />

<img width="1126" height="585" alt="image" src="https://github.com/user-attachments/assets/0e4c7bb6-815b-4459-a3f9-46c426bd9821" />

- Testing Amandil
<img width="1722" height="155" alt="image" src="https://github.com/user-attachments/assets/9fbf07a4-74de-4108-9454-810a3d95f68a" />

<img width="599" height="96" alt="image" src="https://github.com/user-attachments/assets/aa234d33-0d2f-4c59-b2ea-b470f79cac2b" />

<img width="1027" height="329" alt="image" src="https://github.com/user-attachments/assets/d9135ed8-bc05-4c18-a5a3-a860a8475f9d" />

- Testing Khamul

<img width="1678" height="157" alt="image" src="https://github.com/user-attachments/assets/1190bcde-6775-4c56-846a-fb79113f0bc5" />

<img width="606" height="94" alt="image" src="https://github.com/user-attachments/assets/95c34766-d128-4083-9aa6-c5138b610355" />

<img width="1003" height="326" alt="image" src="https://github.com/user-attachments/assets/eb747fd1-f396-4726-b597-07787e17aa17" />


## SOAL 3

Untuk mengontrol arus informasi ke dunia luar (Valinor/Internet), sebuah menara pengawas, Minastir didirikan. Minastir mengatur agar semua node (kecuali Durin) hanya dapat mengirim pesan ke luar Arda setelah melewati pemeriksaan di Minastir.

## Script

```

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
```
## Testing

a. Test dari Minatsir sendiri

dig google.com @127.0.0.1

<img width="967" height="691" alt="image" src="https://github.com/user-attachments/assets/96aad93a-2609-4d88-acef-2c8427edb8a1" />

b. Test di elendil

dig google.com

<img width="886" height="621" alt="image" src="https://github.com/user-attachments/assets/35e5bf6e-b98d-4620-81c8-71ab581f3105" />

ping -c 3 google.com

<img width="1039" height="247" alt="image" src="https://github.com/user-attachments/assets/9d45fbde-fc89-4d8f-96f9-bbb4afba030d" />


c. Test di Gilgalad/Amandil/Khamul (setelah dapat IP dari DHCP)


- Gilgalad

<img width="636" height="100" alt="image" src="https://github.com/user-attachments/assets/e7c36bb6-5514-4002-a422-685a44f84499" />

- Amandil
  
<img width="604" height="100" alt="image" src="https://github.com/user-attachments/assets/9d19d6b4-cfca-48ee-82c1-d49b95a0b7a2" />

- khamul
  
<img width="575" height="127" alt="image" src="https://github.com/user-attachments/assets/40f36d1e-c9d1-42a3-81bb-b934c9787a45" />



## SOAL 4

Ratu Erendis, sang pembuat peta, menetapkan nama resmi untuk wilayah utama (<xxxx>.com). Ia menunjuk dirinya (ns1.<xxxx>.com) dan muridnya Amdir (ns2.<xxxx>.com) sebagai penjaga peta resmi. Setiap lokasi penting (Palantir, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher) diberikan nama domain unik yang menunjuk ke lokasi fisik tanah mereka. Pastikan Amdir selalu menyalin peta (master-slave) dari Erendis dengan setia.

### Erendis
```
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
```

### Amdir

```
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
```
named-checkconf
named-checkzone K11.com /etc/bind/jarkom/K11.com

<img width="1103" height="127" alt="image" src="https://github.com/user-attachments/assets/668b5cf9-4666-4835-b1df-352314278f05" />


tes nslookup palantir.K11.com 127.0.0.1

<img width="811" height="190" alt="image" src="https://github.com/user-attachments/assets/583db0f2-d23b-4a68-b43e-d674c57bf6d2" />

tes nslookup elros.K11.com 127.0.0.1

<img width="763" height="282" alt="image" src="https://github.com/user-attachments/assets/5e790e3b-f4f9-4b94-8cea-5f3d2365986b" />

<img width="1064" height="461" alt="image" src="https://github.com/user-attachments/assets/aabd1905-2cfa-4827-a5bb-4cc994ea46c9" />





`di amdir`

<img width="1188" height="544" alt="image" src="https://github.com/user-attachments/assets/d7ce2a75-72b4-4337-b79d-203f6a1ba8a6" />


<img width="795" height="193" alt="image" src="https://github.com/user-attachments/assets/50a2970e-704c-4b4b-93d0-30b546ab5fca" />


`test dari client` (elendil)


1. Test query ke Erendis (Master)
nslookup palantir.K11.com 10.69.3.2

2. Test query ke Amdir (Slave)
nslookup palantir.K11.com 10.69.3.3

<img width="936" height="395" alt="image" src="https://github.com/user-attachments/assets/5b9104e9-90e3-4392-8d4d-acfa09c12544" />

`test dari client` (elros)


1. Test query ke Erendis (Master)
nslookup palantir.K11.com 10.69.3.2

2. Test query ke Amdir (Slave)
nslookup palantir.K11.com 10.69.3.3

<img width="829" height="402" alt="image" src="https://github.com/user-attachments/assets/668d33e4-4d23-439f-a3bc-f06b5eccceea" />


# SOAL 5

Untuk memudahkan, nama alias www.<xxxx>.com dibuat untuk peta utama <xxxx>.com. Reverse PTR juga dibuat agar lokasi Erendis dan Amdir dapat dilacak dari alamat fisik tanahnya. Erendis juga menambahkan pesan rahasia (TXT record) pada petanya: "Cincin Sauron" yang menunjuk ke lokasi Elros, dan "Aliansi Terakhir" yang menunjuk ke lokasi Pharazon. Pastikan Amdir juga mengetahui pesan rahasia ini.

### Erendis

```
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
```

```
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

```

### Amdir
```

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
```

- Test CNAME
nslookup www.K11.com

<img width="948" height="267" alt="image" src="https://github.com/user-attachments/assets/adea7a3b-0867-4be8-971c-3b96203afe7f" />


- Test TXT 

dig Cincin-Sauron.K11.com TXT @10.69.3.2

<img width="1349" height="663" alt="image" src="https://github.com/user-attachments/assets/cf5c8599-7c77-4b31-9957-58eb882d8156" />


dig Aliansi-Terakhir.K11.com TXT @10.69.3.2

<img width="1393" height="667" alt="image" src="https://github.com/user-attachments/assets/46380104-831f-41cb-8101-b2d60536fbca" />


- Cek syntax

<img width="1224" height="301" alt="image" src="https://github.com/user-attachments/assets/33c78166-312c-44e5-9e1c-b9bf16aaa87d" />


- Test PTR
  
Uji PTR untuk Erendis (10.69.3.2)
dig -x 10.69.3.2 @10.69.3.2

<img width="1172" height="643" alt="image" src="https://github.com/user-attachments/assets/edcd5c3c-0612-4b77-a093-1b13022dd298" />


Uji PTR untuk Amdir (10.69.3.3)
dig -x 10.69.3.3 @10.69.3.2

<img width="1220" height="658" alt="image" src="https://github.com/user-attachments/assets/a2a07b24-9c5c-4e40-93e7-de2f8440fc2a" />

Uji PTR untuk Palantir (10.69.4.2)
dig -x 10.69.4.2 @10.69.3.2

<img width="1230" height="665" alt="image" src="https://github.com/user-attachments/assets/a515e557-8e22-4f57-b529-d5aa9e3c1a92" />



DI AMDIR


<img width="1256" height="512" alt="image" src="https://github.com/user-attachments/assets/4bf7b42b-f882-405b-8a29-104c0b1df453" />

Cek transfer

ls -la /var/lib/bind/

<img width="1049" height="215" alt="image" src="https://github.com/user-attachments/assets/2509dd53-8856-410b-bcba-12890b701399" />


cincin

<img width="1337" height="654" alt="image" src="https://github.com/user-attachments/assets/e9821cf2-80a6-4ce9-8ff3-771c452dfe9f" />

dig www.K11.com @127.0.0.1

<img width="1162" height="695" alt="image" src="https://github.com/user-attachments/assets/40cac76e-aca5-4859-8a84-1a1a4a9029e2" />

dig -x 10.69.3.2 @127.0.0.1

<img width="1127" height="652" alt="image" src="https://github.com/user-attachments/assets/40b63d1f-b248-4e85-8b04-b5fa35828499" />


dig www.com
<img width="1161" height="669" alt="image" src="https://github.com/user-attachments/assets/c37ae3b1-1804-432b-8627-89fc15edd87b" />

dig elros.com

<img width="1276" height="659" alt="image" src="https://github.com/user-attachments/assets/8d5fb6c4-a170-48d9-a9f1-ce33c5411f3c" />


<img width="858" height="65" alt="image" src="https://github.com/user-attachments/assets/d5eea7d5-57cc-444d-b060-5384e1814307" />


# SOAL 6

Aldarion menetapkan aturan waktu peminjaman tanah. Ia mengatur:

- Client Dinamis Keluarga Manusia dapat meminjam tanah selama setengah jam.
- Client Dinamis Keluarga Peri hanya seperenam jam.
- Batas waktu maksimal peminjaman untuk semua adalah satu jam.

## Script

### Aldarion
```
option domain-name "K11.com";
option domain-name-servers 10.69.5.2;

# Global lease time (1 jam = 3600 detik)
default-lease-time 3600;
max-lease-time 3600;

authoritative;
ddns-update-style none;

# SUBNET 10.69.1.0/24 - Keluarga Manusia
# Lease time: 30 menit (1800 detik)

subnet 10.69.1.0 netmask 255.255.255.0 {
    range 10.69.1.6 10.69.1.34;
    range 10.69.1.68 10.69.1.94;
    option routers 10.69.1.1;
    option broadcast-address 10.69.1.255;
    option domain-name-servers 10.69.5.2;
    default-lease-time 1800;  # 30 menit
    max-lease-time 3600;       # 1 jam
}

# SUBNET 10.69.2.0/24 - Keluarga Peri
# Lease time: 10 menit (600 detik = 1/6 jam)

subnet 10.69.2.0 netmask 255.255.255.0 {
    range 10.69.2.35 10.69.2.67;
    range 10.69.2.96 10.69.2.121;
    option routers 10.69.2.1;
    option broadcast-address 10.69.2.255;
    option domain-name-servers 10.69.5.2;
    default-lease-time 600;    # 10 menit (1/6 jam)
    max-lease-time 3600;       # 1 jam
}

subnet 10.69.3.0 netmask 255.255.255.0 {
    option routers 10.69.3.1;
}

subnet 10.69.4.0 netmask 255.255.255.0 {
    option routers 10.69.4.1;
}

subnet 10.69.5.0 netmask 255.255.255.0 {
    option routers 10.69.5.1;
}

host Khamul {
    hardware ethernet 02:00:00:00:00:01;
    fixed-address 10.69.3.95;
}
```

<img width="858" height="130" alt="image" src="https://github.com/user-attachments/assets/2b116752-8574-42e8-8190-914d0934499b" />

<img width="1678" height="736" alt="image" src="https://github.com/user-attachments/assets/642e2a96-acd8-4016-845d-030c07073b2d" />

<img width="1708" height="647" alt="image" src="https://github.com/user-attachments/assets/3564deb8-52d0-4737-a405-896e7556cda6" />

<img width="1468" height="1067" alt="image" src="https://github.com/user-attachments/assets/7cea581c-a6d0-4957-8873-51e16829f99d" />


# SOAL 7

Para Ksatria Númenor (Elendil, Isildur, Anarion) mulai membangun benteng pertahanan digital mereka menggunakan teknologi Laravel. Instal semua tools yang dibutuhkan (php8.4, composer, nginx) dan dapatkan cetak biru benteng dari Resource-laravel di setiap node worker Laravel. Cek dengan lynx di client.


<img width="1041" height="311" alt="image" src="https://github.com/user-attachments/assets/b28508e6-7adf-4ff7-8f0a-ecbd38bf2ef1" />

<img width="1769" height="1061" alt="image" src="https://github.com/user-attachments/assets/30a51fdd-fe68-4533-9c79-402df2ed45e9" />


<img width="700" height="90" alt="image" src="https://github.com/user-attachments/assets/48f2dd36-7f25-4efa-b64e-b1bf1067e163" />

<img width="867" height="171" alt="image" src="https://github.com/user-attachments/assets/4a56c668-f904-4a8d-a8df-c229c5af6041" />


ISILDUR

<img width="1126" height="308" alt="image" src="https://github.com/user-attachments/assets/5d98d233-bb60-4278-9c9a-ed3fade7a9f1" />


<img width="953" height="117" alt="image" src="https://github.com/user-attachments/assets/4bcdfb99-38d2-475e-8129-2fdc284c27a0" />


<img width="1591" height="162" alt="image" src="https://github.com/user-attachments/assets/257543a6-8e0d-461c-8737-57e66eea36a6" />


ANARION

<img width="1087" height="310" alt="image" src="https://github.com/user-attachments/assets/221ddc38-3b50-47d4-b7df-42fb5a3692bd" />


<img width="894" height="129" alt="image" src="https://github.com/user-attachments/assets/b5fefc10-9628-4c64-b3e0-20f825f9499a" />


<img width="1532" height="165" alt="image" src="https://github.com/user-attachments/assets/a8e6b829-9389-4fde-b403-2e059aaef49b" />


<img width="1905" height="1078" alt="image" src="https://github.com/user-attachments/assets/c2dafd80-d76a-4bcd-a936-f98b6ea85672" />

# SOAL 8

Setiap benteng Númenor harus terhubung ke sumber pengetahuan, Palantir. Konfigurasikan koneksi database di file .env masing-masing worker. Setiap benteng juga harus memiliki gerbang masuk yang unik; atur nginx agar Elendil mendengarkan di port 8001, Isildur di 8002, dan Anarion di 8003. Jangan lupa jalankan migrasi dan seeding awal dari Elendil. Buat agar akses web hanya bisa melalui domain nama, tidak bisa melalui ip.

## Script

### Palantir

```
# 1. Install paket
apt-get update
apt-get install -y mariadb-server net-tools

# 2. Mulai service
service mariadb start

# 3. Buat database dan user
mariadb -e "
DROP USER IF EXISTS 'K11_user'@'%';
CREATE USER 'K11_user'@'%' IDENTIFIED BY 'passwordK11';
CREATE DATABASE IF NOT EXISTS db_K11;
GRANT ALL PRIVILEGES ON db_K11.* TO 'K11_user'@'%';
FLUSH PRIVILEGES;
"

# 4. Hentikan service untuk mengedit file
service mariadb stop

# 5. Tentukan file konfigurasi
CONFIG_FILE="/etc/mysql/mariadb.conf.d/50-server.cnf"
if [ ! -f "$CONFIG_FILE" ]; then
    CONFIG_FILE="/etc/mysql/my.cnf"
fi

# 6. Perbaikan: Izinkan koneksi eksternal (mengomentari bind-address)
sed -i "s/bind-address\s*=\s*127.0.0.1/#bind-address = 127.0.0.1/" "$CONFIG_FILE"
sed -i "/skip-networking/d" "$CONFIG_FILE"

# 7. Mulai service lagi
service mariadb start
```

<img width="1531" height="852" alt="image" src="https://github.com/user-attachments/assets/93694ca3-de5e-421e-b35a-4c7635e15780" />

<img width="1537" height="405" alt="image" src="https://github.com/user-attachments/assets/25a0fd7c-ee52-499f-9bfa-c27c60ba6104" />




# SOAL 10

Pemimpin bijak Elros ditugaskan untuk mengkoordinasikan pertahanan Númenor. Konfigurasikan nginx di Elros untuk bertindak sebagai reverse proxy. Buat upstream bernama kesatria_numenor yang berisi alamat ketiga worker (Elendil, Isildur, Anarion). Atur agar semua permintaan yang datang ke domain elros..com diteruskan secara merata menggunakan algoritma Round Robin ke backend.

## Script

```
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
```


<img width="1708" height="266" alt="image" src="https://github.com/user-attachments/assets/65205443-6748-4652-aea6-35c8467047d0" />

<img width="1236" height="278" alt="image" src="https://github.com/user-attachments/assets/1a69d123-5197-49f1-bac0-3f303ff20686" />

