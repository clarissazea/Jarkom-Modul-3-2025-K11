# a. ALDARION (IP: 10.69.4.4)

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

# 7. cek status
service isc-dhcp-server status

# b. DURIN

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

# 4. Cek status
service isc-dhcp-relay status