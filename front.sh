#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install dropbear stunnel nodejs gcc cmake make build-essential unzip zip openssl net-tools -y
sudo chmod 0777 /etc/default/dropbear
echo "IyBkaXNhYmxlZCBiZWNhdXNlIE9wZW5TU0ggaXMgaW5zdGFsbGVkCiMgY2hhbmdlIHRvIE5PX1NUQVJUPTAgdG8gZW5hYmxlIERyb3BiZWFyCk5PX1NUQVJUPTAKIyB0aGUgVENQIHBvcnQgdGhhdCBEcm9wYmVhciBsaXN0ZW5zIG9uCkRST1BCRUFSX1BPUlQ9NDAwMDAKCiMgYW55IGFkZGl0aW9uYWwgYXJndW1lbnRzIGZvciBEcm9wYmVhcgpEUk9QQkVBUl9FWFRSQV9BUkdTPSIiCgojIHNwZWNpZnkgYW4gb3B0aW9uYWwgYmFubmVyIGZpbGUgY29udGFpbmluZyBhIG1lc3NhZ2UgdG8gYmUKIyBzZW50IHRvIGNsaWVudHMgYmVmb3JlIHRoZXkgY29ubmVjdCwgc3VjaCBhcyAiL2V0Yy9pc3N1ZS5uZXQiCkRST1BCRUFSX0JBTk5FUj0iIgoKIyBSU0EgaG9zdGtleSBmaWxlIChkZWZhdWx0OiAvZXRjL2Ryb3BiZWFyL2Ryb3BiZWFyX3JzYV9ob3N0X2tleSkKI0RST1BCRUFSX1JTQUtFWT0iL2V0Yy9kcm9wYmVhci9kcm9wYmVhcl9yc2FfaG9zdF9rZXkiCgojIERTUyBob3N0a2V5IGZpbGUgKGRlZmF1bHQ6IC9ldGMvZHJvcGJlYXIvZHJvcGJlYXJfZHNzX2hvc3Rfa2V5KQojRFJPUEJFQVJfRFNTS0VZPSIvZXRjL2Ryb3BiZWFyL2Ryb3BiZWFyX2Rzc19ob3N0X2tleSIKCiMgRUNEU0EgaG9zdGtleSBmaWxlIChkZWZhdWx0OiAvZXRjL2Ryb3BiZWFyL2Ryb3BiZWFyX2VjZHNhX2hvc3Rfa2V5KQojRFJPUEJFQVJfRUNEU0FLRVk9Ii9ldGMvZHJvcGJlYXIvZHJvcGJlYXJfZWNkc2FfaG9zdF9rZXkiCgojIFJlY2VpdmUgd2luZG93IHNpemUgLSB0aGlzIGlzIGEgdHJhZGVvZmYgYmV0d2VlbiBtZW1vcnkgYW5kCiMgbmV0d29yayBwZXJmb3JtYW5jZQpEUk9QQkVBUl9SRUNFSVZFX1dJTkRPVz02NTUzNgo=" | base64 --decode > /etc/default/dropbear
sudo chmod 0644 /etc/default/dropbear
sudo chmod 0777 /etc/shells
echo -e "/bin/false\r\n/usr/sbin/nologin" >> /etc/shells
sudo chmod 0644 /etc/shells
sudo sed -i "s/enforce_for_root //g" /etc/pam.d/common-password
sudo sed -i "s/enforce_for_root//g" /etc/pam.d/common-password
sudo mkdir /etc/HScommon
sudo wget https://github.com/ambrop72/badvpn/archive/master.zip -P /tmp
sudo wget https://raw.githubusercontent.com/buklaisvas/vps/main/proxy3.js -P /etc/HScommon
sudo wget https://raw.githubusercontent.com/buklaisvas/vps/main/badvpn.service -P /etc/systemd/system
sudo wget https://raw.githubusercontent.com/buklaisvas/vps/main/nodews1.service -P /etc/systemd/system
sudo wget https://raw.githubusercontent.com/buklaisvas/vps/main/stunnel.conf -P /etc/stunnel
sudo unzip /tmp/master.zip -d /tmp
cd /tmp/badvpn-master && mkdir build && cd build
sudo cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
sudo make install
cd /etc/stunnel
sudo openssl genrsa -out key.pem 2048
sudo openssl req -new -x509 -key key.pem -out cert.pem -subj "/C=US/ST=California/L=California/O=Common/OU=Common/CN=*/EMAIL=abuse@common.com" -days 1095
cat key.pem cert.pem > stunnel.pem
sudo systemctl enable badvpn
sudo systemctl start badvpn
sudo systemctl enable nodews1
sudo systemctl start nodews1
sudo systemctl enable stunnel4
sudo systemctl restart stunnel4
sleep 15
clear
echo "===================="
echo "FINISH SCRIPTS"
echo "===================="
sleep 15
sudo shutdown -r 1
exit