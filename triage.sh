#!/bin/bash

hostname=uname -n

sudo echo "[*] Beginning live triage on $hostname..."
sudo mkdir logs/$hostname
sudo echo "[*] Gathering system information..."
log="./logs/$hostname/sys-info.log"
sudo echo "[+] System Info ---------------------------------------------------" >> $log
sudo uname -a >> $log
sudo echo -e "\n[+] Date/Time:" >> $log
sudo timedatectl >> $log
sudo echo -e "\n[+] Uptime:" >> $log
sudo uptime >> $log
sudo mount >> $log
sudo echo $PATH >> $log

sudo echo "[*] Gathering information on users..." 
log="./logs/$hostname/user-info.log"
sudo echo "[+] Users Info ---------------------------------------------------" >> $log
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
log="./logs/$hostname/net-info.log"
sudo echo "[+] Network Info ---------------------------------------------------" >> $log
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
sudo apr -a >> $log

sudo echo "[*] Gathering services information..."
log="./logs/$hostname/service-info.log"
sudo echo "[+] Service Info ---------------------------------------------------" >> $log
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

sudo echo "[*] Gathering autorun/autoload information..."
log="./logs/$hostname/autorun-info.log"
sudo echo "[+] Autorun/Autoload Info ---------------------------------------------------" >> $log
sudo echo -e "\n[+] Cron jobs:" >> $log
sudo crontab -l >> $log
sudo echo -e "\n[+] Root/UID0 Cron jobs:" >> $log
sudo crontab -u root -l >> $log
sudo echo -e "\n[+] Review for unusual cron jobs:" >> $log
sudo ls /etc/cron.* >> $log
sudo cat /etc/crontab >> $log

sudo echo "[*] Gathering file, drive, and share information..."
log="./logs/$hostname/file-info.log"
sudo echo "[+] File, Drives, and Share Info ---------------------------------------------------" >> $log
sudo echo -e "\n[+] Disk Space:" >> $log
sudo df -ah >> $log
sudo echo -e "\n[+] Directory listing for root:" >> $log
sudo ls -splah >> $log
sudo echo -e "\n[+] Directory listing for /etc/init.d:" >> $log
sudo ls -splah /etc/init.d >> $log
sudo echo -e "\n[+] Files over 100MB:" >> $log
sudo find / -size +100000k -maxdepth 30 -printf "%m;%Ax;%AT;%Tx;%TT;%Cx;%CT;%U;%G;%s;%p\n" >> $log
sudo echo -e "\n[+] Full filesystem and attributes:" >> $log
sudo find / -printf "%m;%Ax;%AT;%Tx;%TT;%Cx;%CT;%U;%G;%s;%p\n" >> $log

sudo echo "[+] Attempting to run chkrootkit..."
sudo chkrootkit >> $log

sudo echo "[!] Done!"
done
