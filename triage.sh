#!/bin/bash
sudo echo "[*] Ensure you've installed lsof through apt or pacman."
sudo echo "[*] Beginning live triage on Linux filesystem."
sudo mkdir log

sudo echo "[*] Gathering system information..."
log='./log/sys-info.log'
sudo echo -e "\n[+] System Info ---------------------------------------------------" >> $log
sudo uname -a >> $log
sudo echo "\n[+] Date/Time:" >> $log
sudo timedatectl >> $log
sudo echo -e "\n[+] Uptime:" >> $log
sudo uptime >> $log
sudo mount >> $log
sudo echo $PATH >> $log

sudo echo "[*] Gathering information on users..." 
log='./log/user-info.log'
sudo echo -e "\n[+] Users Info ---------------------------------------------------" >> $log
sudo echo -e "\n[+] Logged in currently:" >> $log
sudo w >> $log
sudo echo -e "\n[+] Which users have logged in remotely?" >> $log
sudo echo "[+] lastlog output:" >> $log
sudo lastlog >> $log
sudo echo "[+] last output:" >> $log
sudo last >> $log
sudo echo -e "\n[+] Failed logins:" >> $log
sudo faillog -a >> $log
sudo echo -e "\n[+] Local user account info:" >> $log
sudo cat /etc/passwd >> $log
sudo cat /etc/shadow >> $log
sudo echo -e "\n[+] Groups info:" >> $log
sudo cat /etc/group >> $log
sudo echo -e "\n[+] Sudoers file:" >> $log
sudo cat /etc/sudoers >> $log
sudo echo -e "\n[+] Accounts with UID 0:" >> $log
sudo egrep ':0+' /etc/passwd >> $log
sudo echo -e "\n[+] Root authorized SSH keys:" >> $log
sudo cat /root/.ssh/authorized_keys
sudo echo -e "\n[+] Root user .bash_history:" >> $log
sudo cat /root/.bash_history >> $log

sudo echo "[*] Gathering network information..."
log='./log/net-info.log'
sudo echo -e "\n[+] Network Info ---------------------------------------------------" >> $log
sudo echo -e "\n[+] Interfaces:" >> $log
sudo ifconfig >> $log
sudo echo -e "\n[+] Connections:" >> $log
sudo netstat -plantux >> $log
sudo echo -e "\n [+] Listening ports" >> $log
sudo netstat -nap >> $log
sudo echo -e "\n[+] Processes listening on ports:" >> $log
sudo lsof -i >> $log
sudo echo -e "\n[+] Routes:" >> $log
sudo route >> $log
sudo echo -e "\n[+] Hosts:" >> $log
sudo cat /etc/hosts >> $log
sudo echo -e "\n[+] ARP table:" >> $log
sudo arp -a >> $log

sudo echo "[*] Gathering services information..."
log='./log/service-info.log'
sudo echo -e "\n[+] Service Info ---------------------------------------------------" >> $log
sudo echo -e "\n[+] Running services:" >> $log
sudo ps -aux >> $log
sudo echo -e "\n[+] Load modules:" >> $log
sudo lsmod >> $log
sudo echo -e "\n[+] Open files:" >> $log
sudo lsof >> $log
sudo echo -e "\n[+] Files open over network:" >> $log
sudo lsof -nPi | cut -f 1 -d " " | uniq | tail -n +2 >> $log
sudo echo -e "\n[+] Unlinked processes:" >> $log
sudo lsof +L1 >> $log

sudo echo -e"\[!] Done!"
sudo echo "[*] That's all for now, this script is still a work in progress."
exit
