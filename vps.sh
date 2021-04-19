#!/bin/bash

# curl -o https://raw.githubusercontent.com/vps0/vps/main/post_install.sh
# chmod +x post_install.sh
#./post_install.sh

#=====================================================================================================

# +++ Test to see if user is running with root privileges +++
if [[ "${UID}" -ne 0 ]]
then
 echo 'Must execute with sudo or root' >&2
 exit 1
fi

# +++ Ensure system is up to date +++
sudo apt update -y 

# +++ Upgrade the system +++
sudo apt upgrade -y

# +++ Install OpenSSH +++
sudo apt install openssh-server -y

# +++ Enable Firewall +++
sudo ufw enable 

# +++ configure the firewall +++
sudo ufw allow OpenSSH

# +++ Disabling root login +++
echo "PermitRootLogin no" >> /etc/ssh/sshd_config 
echo "PermitEmptyPasswords no" /etc/ssh/sshd_config

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
maxretry = 4
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

#=====================================================================================================

# +++ Docker option install +++

echo "
######################################################################################################

Do you want to install docker? If so type y / If you dont want to install enter n

######################################################################################################
"
read $docker

if [[ $docker -eq "y" ]] || [[ $docker -eq "yes" ]]; then
    sudo apt update -y
    sudo apt install docker.io -y
    sudo apt install docker-compose -y
    sudo -i
    sudo systemctl start docker
    sudo systemctl enable docker
    docker version

    echo " 
    
        Installing Portainer on port 19000

    "

    sudo docker volume create portainer_data
    sudo docker run -d -p 18000:18000 -p 19000:19000 --name=portainer --restart=always --pull=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

    docker ps

    echo "
#####################################################################################################    
                            Congrats! Docker has been installed!
######################################################################################################
"
    docker -v

else 
    echo "Docker was not installed"
 
fi

#=====================================================================================================

# +++ Wireguard install +++

echo "
#####################################################################################################

Would you like to install a wireguard VPN Server? If so enter y / If you dont want to install enter n

######################################################################################################
"
read $vpn

if [[ $vpn -eq "y" ]] || [ $vpn -eq "yes" ]] ; then 
    wget https://raw.githubusercontent.com/l-n-s/wireguard-install/master/wireguard-install.sh -O wireguard-install.sh
    bash wireguard-install.sh

elif  [[ $vpn -eq "n" ]] || [ $vpn -eq "no" ]] ; then 
    echo "Wireguard was NOT installed by user."
else 
    echo "Error Install Aborted!"
    exit 1
fi

#=====================================================================================================


# +++ Cleanup +++ 
sudo apt autoremove
sudo apt clean 
#
#
#=====================================================================================================
#
#
echo "
######################################################################################################

Reboot your server to fully configure the vpn service.

When using the VPN service on a device simply use the config file in you home directory. 
To create a new config enter  bash wireguard-install.sh in the cli and choose a new name.

If you installed Docker a portainer management image is running on ip:19000.

######################################################################################################
"

exit 0
