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

- Test CNAME
nslookup www.K11.com

<img width="948" height="267" alt="image" src="https://github.com/user-attachments/assets/adea7a3b-0867-4be8-971c-3b96203afe7f" />


- Test TXT 

dig Cincin-Sauron.K11.com TXT @10.69.3.2

<img width="1349" height="663" alt="image" src="https://github.com/user-attachments/assets/cf5c8599-7c77-4b31-9957-58eb882d8156" />


dig Aliansi-Terakhir.K11.com TXT @10.69.3.2

<img width="1393" height="667" alt="image" src="https://github.com/user-attachments/assets/46380104-831f-41cb-8101-b2d60536fbca" />


- Cek syntax
named-checkconf
named-checkzone 3.69.10.in-addr.arpa /etc/bind/jarkom/3.69.10.in-addr.arpa
named-checkzone 4.69.10.in-addr.arpa /etc/bind/jarkom/4.69.10.in-addr.arpa

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


# SOAL 6

<img width="858" height="130" alt="image" src="https://github.com/user-attachments/assets/2b116752-8574-42e8-8190-914d0934499b" />

<img width="1678" height="736" alt="image" src="https://github.com/user-attachments/assets/642e2a96-acd8-4016-845d-030c07073b2d" />

<img width="1708" height="647" alt="image" src="https://github.com/user-attachments/assets/3564deb8-52d0-4737-a405-896e7556cda6" />


# SOAL 7

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

