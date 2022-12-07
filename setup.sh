#!/usr/bin/env bash
set -o xtrace

# Sync package database and ensure packages are up to date
sudo pacman -Syu

# Install minimal desktop
sudo pacman -Syu                 \
	gdm                      \
	gnome-console            \
	gnome-control-center     \
	gnome-keyring            \
	gnome-shell              \
	gnome-text-editor        \
	gnome-tweaks             \
	nautilus                 \
	nano                     \
	nfs-utils                \
	xdg-user-dirs            \
	xdg-desktop-portal       \
	xdg-desktop-portal-gnome \

# Enable and start display manager
sudo systemctl enable gdm
sudo systemctl start gdm

# Create standard user directories
xdg-user-dirs-update

# Create additional directories
mkdir ./{Archive,Books,Projects,Unsorted,Roms}

# Install yay
# See: https://github.com/Jguer/yay#binary
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
pushd yay-bin
makepkg -si
popd
rm -rf yay-bin

# Generate development package database used for devel update.
yay -Y --gendb

# Make combined upgrade and batch install the default.
yay -Y --devel --combinedupgrade --batchinstall --save

# Perform system upgrade, but also check for development package updates.
yay -Syu --devel

# Chrome & Gnome Browser Connector
yay -Syu gnome-browser-connector google-chrome

# Install Grand Theft Focus from https://extensions.gnome.org/extension/5410/grand-theft-focus/

# Install packages.
yay -Syu \
  # Repo
  beets \
  python-requests \
  nicotine+ \
  podman-docker \
  gnome-shell-extension-appindicator \
  ttf-fira-code \
  virt-manager \
  qemu-desktop \
  libvirt \
  edk2-ovmf \
  dnsmasq \
  iptables-nft \
  community/pycharm-community-edition \
  # AUR
  amberol \
  cambalache \
  expressvpn \
  expressvpn-gui \
  github-desktop-bin \
  gnome-shell-extension-tiling-assistant \
  gnome-shell-extension-no-annoyance \
  google-chrome \
  visual-studio-code-bin \
  xrdp

# Enable and start xrdp
sudo systemctl enable xrdp.service
sudo systemctl start xrdp.service

# Don't require encryption for RDP sessions
gsettings set org.gnome.desktop.remote-desktop.vnc encryption "['none']"

# Allow RDP sessions through the firewall
sudo firewall-cmd --permanent --add-service=rdp
sudo firewall-cmd --reload

# Enable and start libvertd
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

# Clean unneeded dependencies.
yay -Yc

# Restore Gnome settings
# Backup: dconf dump /org/gnome > gnome-backup
dconf load /org/gnome < gnome-backup

# Mount NAS volumes
sudo cat <<EOT >> /etc/fstab
nas.lan:/Archive  /home/kyle/Archive  nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Books    /home/kyle/Books    nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Music    /home/kyle/Music    nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Videos   /home/kyle/Videos   nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Music    /home/kyle/Music    nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Unsorted /home/kyle/Unsorted nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Photos   /home/kyle/Pictures nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Roms     /home/kyle/Roms     nfs defaults,timeo=900,retrans=5,_netdev 0 0
EOT
sudo mount -a

# Beets config
mkdir -p ~/.config/beets
cat > ~/.config/beets/config.yaml << EOF
directory: ~/Music
library: ~/Music/musiclibrary.db
plugins: fetchart
fetchart:
    auto: yes
EOF
