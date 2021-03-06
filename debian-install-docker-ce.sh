#!/bin/bash
# Install Docker and Docker-Compose
# Originally created For Debian on WSL v.2

sudo apt update
sudo apt install -y apt-transport-https \
	ca-certificates \
	curl \
	software-properties-common \
	gnupg2
sudo apt purge docker lxc-docker docker-engine docker.io containerd.io
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster edge"
sudo apt update
sudo apt install -y docker-ce 
# Weird bit for WSL2
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
#sudo iptables --wait -t nat -L -n
mkdir /home/"$USER"/.docker
sudo touch /etc/fstab
echo "LABEL=cloudimg-rootfs   /        ext4   defaults        0 0" | sudo tee -a /etc/fstab
# Allow $USER to run Docker commands without sudo
sudo usermod -aG docker ${USER}
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chown 755 "$HOME/.docker" -R

sudo service docker start
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version

