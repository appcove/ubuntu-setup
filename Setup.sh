#!/bin/bash

cd $(dirname $0)

#Install needed programs
sudo apt install -y curl gpg

# Install appcove developer software repo
curl -sLO https://appcove.github.io/developer-software/ubuntu/dists/jammy/main/binary-amd64/ads-release_1.0.0custom22.04_amd64.deb
sudo dpkg -i ads-release_1.0.0custom22.04_amd64.deb

# Install docker repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo dd of=/etc/apt/sources.list.d/docker.list

# Install and prepare VSCode PPA
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

# Update apt
sudo apt update

# Install all ads packages
sudo apt install ads-everything

# Install VSCode
sudo apt install code

# Basic packages 
sudo apt install build-essential git git-lfs sshfs vim rsync curl net-tools postgresql-client-14 tree redis-tools libfuse2  gnome-shell-extension-manager

# For remote access to other systems
sudo apt install sshfs

# For egui 
sudo apt install libxcb-shape0-dev libxcb-xfixes0-dev

# For fuse work
sudo apt-get install libfuse-dev pkg-config

# Set defaults
sudo update-alternatives --set editor /usr/bin/vim.basic

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install docker
sudo apt update
sudo apt install -y docker-ce-cli containerd.io docker-compose-plugin
sudo apt install -y docker-ce || echo "failure to start docker this time -- stupid hack"
sudo systemctl enable docker
sudo usermod -aG docker $USER

echo "----------------------------------"
echo
#echo "Visual Studio Code Download: https://code.visualstudio.com/docs/?dv=linux64_deb"
echo
echo "Run Extension manager: extension-manager"
echo
echo "GitHub CLI: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
echo
echo "you are using:"
echo $XDG_SESSION_TYPE
echo
echo "If you are using wayland, run: sudo vim /etc/gdm3/custom.conf"
echo "and in the file change: WaylandEnable=true, to: WaylandEnable=false, and then restart your machine"
echo
