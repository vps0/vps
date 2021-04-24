#!/bin/bash

# New VPS Set Up, Hardening, and Docker/Portainer Install
# wget https://raw.githubusercontent.com/vps0/vps/main/vps.sh
# chmod +x vps.sh
#./vps.sh

#============================================================================

# +++ Test to see if user is running with root privileges +++
if [[ "${UID}" -ne 0 ]]
then
 echo 'Must execute with sudo or root' >&2
 exit 1
fi

#============================================================================

# +++ Ensure system is up to date +++
sudo apt update -y 

# +++ Upgrade the system +++
sudo apt upgrade -y

# +++ Install OpenSSH +++
sudo apt install openssh-server -y

# +++ Enable Firewall +++
#sudo apt install ufw -y
#sudo ufw enable 

# +++ configure the firewall +++
#sudo ufw allow OpenSSH
#sudo wget -O /usr/local/bin/ufw-docker \
#  https://github.com/chaifeng/ufw-docker/raw/master/ufw-docker
#sudo chmod +x /usr/local/bin/ufw-docker
#sudo ufw-docker install

# +++ Copying ssh keys to new user dir (if not root) +++
sudo mkdir ~/.ssh/
sudo cp /root/.ssh/authorized_keys ~/.ssh/authorized_keys
sudo mkdir /.ssh/
sudo cp /root/.ssh/authorized_keys /.ssh/authorized_keys

# +++ Hardening +++
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
echo "
PermitRootLogin no
PermitEmptyPasswords no
PubkeyAuthentication yes

" >> /etc/ssh/sshd_config

#Clean Duplicate Entries
#sudo awk '!seen[$0]++' /etc/ssh/sshd_config > /etc/ssh/sshd_config1
#sudo cp /etc/ssh/sshd_config1 /etc/ssh/sshd_config
#sudo rm -f /etc/ssh/sshd_config1

# +++ Message of the day +++
sudo wget https://raw.githubusercontent.com/vps0/vps/main/motd.sh
sudo mv motd.sh /etc/update-motd.d/05-info
sudo chmod +x /etc/update-motd.d/05-info

# +++ Automatic downloads of security updates +++
sudo apt install -y unattended-upgrades
echo "Unattended-Upgrade::Allowed-Origins {
#   "${distro_id}:${distro_codename}-security";
#//  "${distro_id}:${distro_codename}-updates";
#//  "${distro_id}:${distro_codename}-proposed";
#//  "${distro_id}:${distro_codename}-backports";

#Unattended-Upgrade::Automatic-Reboot "true"; 
#}; " >> /etc/apt/apt.conf.d/50unattended-upgrades

# +++ Fail2Ban install +++
sudo apt install -y fail2ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

echo "
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
" >> /etc/fail2ban/jail.local

# +++ SFTP Server / FTP server that runs over ssh +++
echo "
Match group sftp
ChrootDirectory /home
X11Forwarding no
AllowTcpForwarding no
ForceCommand internal-sftp
" >> /etc/ssh/sshd_config

sudo service ssh restart  

#============================================================================
# +++ Docker option install +++
#============================================================================
echo "
####################################
#       Installing Docker
####################################
"

    sudo apt update -y
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    sudo apt install docker.io -y
    sudo apt install docker-compose -y
    sudo systemctl start docker
    sudo systemctl enable docker
    docker version

    echo "
####################################
# Installing Portainer on port 9000
####################################
"
    sudo docker volume create portainer_data
    sudo docker run -d -p 19000:19000 --name=portainer --restart=always --pull=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

    docker ps

    echo "
####################################    
Congrats! Docker has been installed!
####################################
"
    docker -v

#===================================
# +++ Wireguard install +++
#===================================
echo "
####################################
Would you like to install a wireguard VPN Server? 
If so enter y / If you dont want to install enter n
####################################
"
#read vpn

#	if [[ $vpn == 'n' ]]; then
echo "Wireguard was NOT installed by user. \nError 420 - Install Aborted By User!" 
echo "Error 420 - Install Aborted By User!"

#	elif [[ $vpn == 'y' ]]; then
#wget https://raw.githubusercontent.com/l-n-s/wireguard-install/master/wireguard-install.sh -O wireguard-install.sh
#bash wireguard-install.sh

#	fi

#============================================================================
# +++ Cleanup +++ 
#============================================================================

sudo apt autoremove -y
sudo apt clean  -y
#

echo "
#############################################################################
If you installed Docker a portainer management image is running on ip:9000.
#############################################################################
"

exit 0
