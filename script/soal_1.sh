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