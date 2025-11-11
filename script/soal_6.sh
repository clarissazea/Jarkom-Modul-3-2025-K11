
# ALDARION (update konfigurasi)

# jangan lupa ganti
cat > /etc/resolv.conf << 'EOF'
nameserver 10.69.5.2
nameserver 10.69.3.2
nameserver 10.69.3.3
EOF

# 1. Update DHCP config dengan lease time baru
cat > /etc/dhcp/dhcpd.conf << 'EOF'
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
EOF

# 2. Restart DHCP Server
service isc-dhcp-server restart
