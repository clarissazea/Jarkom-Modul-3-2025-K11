# Jarkom-Modul-3-2025-K11

## SOAL 1

<img width="1449" height="674" alt="image" src="https://github.com/user-attachments/assets/5b3c2dfb-4fc7-4e2f-bf5a-811004fed5c3" />

```
# Cek routing
ip route

# Cek NAT/iptables
iptables -t nat -L -v

# Cek IP forwarding
cat /proc/sys/net/ipv4/ip_forward
# Harus output: 1
```

<img width="921" height="449" alt="image" src="https://github.com/user-attachments/assets/1d078445-edf9-4343-b72e-5833cf615e66" />


ping durin ke palantir

<img width="1095" height="336" alt="image" src="https://github.com/user-attachments/assets/5a3a0527-927f-4959-ae60-403e9180d611" />

`ping -c 2 google.com`
<img width="1322" height="245" alt="image" src="https://github.com/user-attachments/assets/aaf643f6-8a83-409f-963b-303d493c7d73" />

`ping isildur`
<img width="1390" height="317" alt="image" src="https://github.com/user-attachments/assets/e4383315-87e6-40da-b94a-10007b3508b0" />

`ping Anarion`
<img width="1339" height="314" alt="image" src="https://github.com/user-attachments/assets/3510de04-ab99-4647-9c57-3d63df8dce32" />

## SOAL 2

RESTART

<img width="784" height="346" alt="image" src="https://github.com/user-attachments/assets/5943a602-74ad-4c9a-9ae5-f9284c770a67" />

ALDARION

<img width="840" height="160" alt="image" src="https://github.com/user-attachments/assets/6b3fc468-48d2-43da-b21e-333283dfd3e7" />

DURIN

<img width="814" height="188" alt="image" src="https://github.com/user-attachments/assets/e94ae2a6-2d0a-4e8d-802c-e1be1241a46d" />


STATUS DURIN 

<img width="733" height="256" alt="image" src="https://github.com/user-attachments/assets/f503627b-f9a2-4b58-8a42-988c9b3562f7" />


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

a. test dari minatsir sendiri

<img width="852" height="136" alt="image" src="https://github.com/user-attachments/assets/a424c44c-3042-4b05-aac5-0253613de1d8" />

nslookup google.com 127.0.0.1

<img width="717" height="669" alt="image" src="https://github.com/user-attachments/assets/0c92d64a-bdde-4f1f-b7dd-186cbc36513e" />

dig google.com @127.0.0.1

<img width="967" height="691" alt="image" src="https://github.com/user-attachments/assets/96aad93a-2609-4d88-acef-2c8427edb8a1" />



b. test di elendil

nslookup google.com

<img width="556" height="639" alt="image" src="https://github.com/user-attachments/assets/cbe518a2-ebba-4a88-85b2-fa6de4a89cb7" />

dig google.com

<img width="886" height="621" alt="image" src="https://github.com/user-attachments/assets/35e5bf6e-b98d-4620-81c8-71ab581f3105" />

ping -c 3 google.com

<img width="1039" height="247" alt="image" src="https://github.com/user-attachments/assets/9d45fbde-fc89-4d8f-96f9-bbb4afba030d" />


c. Test di Gilgalad/Amandil/Khamul (setelah dapat IP dari DHCP)


- gilgalad

<img width="636" height="100" alt="image" src="https://github.com/user-attachments/assets/e7c36bb6-5514-4002-a422-685a44f84499" />

- Amandil
  
<img width="604" height="100" alt="image" src="https://github.com/user-attachments/assets/9d19d6b4-cfca-48ee-82c1-d49b95a0b7a2" />

- khamul
  
<img width="575" height="127" alt="image" src="https://github.com/user-attachments/assets/40f36d1e-c9d1-42a3-81bb-b934c9787a45" />



## SOAL 4

named-checkconf
named-checkzone K11.com /etc/bind/jarkom/K11.com

<img width="1103" height="127" alt="image" src="https://github.com/user-attachments/assets/668b5cf9-4666-4835-b1df-352314278f05" />


tes nslookup palantir.K11.com 127.0.0.1

<img width="811" height="190" alt="image" src="https://github.com/user-attachments/assets/583db0f2-d23b-4a68-b43e-d674c57bf6d2" />

tes nslookup elros.K11.com 127.0.0.1

<img width="763" height="282" alt="image" src="https://github.com/user-attachments/assets/5e790e3b-f4f9-4b94-8cea-5f3d2365986b" />






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

- Test CNAME
nslookup www.K11.com

<img width="926" height="243" alt="image" src="https://github.com/user-attachments/assets/467f7582-cdda-472c-82e0-41232daa9fc8" />

- Test TXT 

dig Cincin-Sauron.K11.com TXT

<img width="1796" height="587" alt="image" src="https://github.com/user-attachments/assets/ed6669df-a76d-485a-84ab-70ce4cdca2fb" />

dig Aliansi-Terakhir.K11.com TXT

<img width="1772" height="595" alt="image" src="https://github.com/user-attachments/assets/349b16aa-09be-4763-96fe-4141e1838b21" />

- Cek syntax
named-checkconf
named-checkzone 3.69.10.in-addr.arpa /etc/bind/jarkom/3.69.10.in-addr.arpa
named-checkzone 4.69.10.in-addr.arpa /etc/bind/jarkom/4.69.10.in-addr.arpa

<img width="1319" height="207" alt="image" src="https://github.com/user-attachments/assets/02706dd0-edef-4a14-b6b3-151b19d54112" />

- Test PTR
dig -x 10.69.3.2

<img width="1361" height="574" alt="image" src="https://github.com/user-attachments/assets/5ebbd1b4-3d73-4387-9d10-662798a45f99" />

dig -x 10.69.3.3

<img width="1362" height="583" alt="image" src="https://github.com/user-attachments/assets/01140515-53cd-4ff6-a5dc-dc8a98c0aebd" />



DI AMDIR

<img width="975" height="220" alt="image" src="https://github.com/user-attachments/assets/91ccfbb5-19d1-4293-b5f6-6a8e2c1599d0" />


cincin

<img width="1315" height="653" alt="image" src="https://github.com/user-attachments/assets/31ed4500-6d80-4a30-8909-f2583e2094f0" />

aliansi terakhir

<img width="1377" height="656" alt="image" src="https://github.com/user-attachments/assets/bc07cfac-6520-431f-8525-24f55e0d7aa3" />

tes dig 

<img width="1117" height="658" alt="image" src="https://github.com/user-attachments/assets/f99b01bc-efce-4d18-8fa2-d86cde28dfc5" />




# baruuu soal 5

<img width="975" height="92" alt="image" src="https://github.com/user-attachments/assets/259f7966-453f-4ab2-88b1-b39604b1140b" />


<img width="1350" height="173" alt="image" src="https://github.com/user-attachments/assets/d4017b87-3a8b-47a5-ab6d-bccf73c81db2" />



# SOAL 6

