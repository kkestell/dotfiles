# Arch

## NFS Shares

```console
$ sudo cat <<EOT >> /etc/fstab
nas.lan:/Archive   /home/kyle/Archive   nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Books     /home/kyle/Books     nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Documents /home/kyle/Documents nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Music     /home/kyle/Music     nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Videos    /home/kyle/Videos    nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Music     /home/kyle/Music     nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Unsorted  /home/kyle/Unsorted  nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Photos    /home/kyle/Pictures  nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Projects  /home/kyle/Projects  nfs defaults,timeo=900,retrans=5,_netdev 0 0
nas.lan:/Roms      /home/kyle/Roms      nfs defaults,timeo=900,retrans=5,_netdev 0 0
EOT
```

```console
$ mkdir -p ~/{Archive,Books,Unsorted,Projects,Roms}
```

```console
$ sudo systemctl daemon-reload
$ sudo mount -a
```

## Package Management

Clean unneeded dependencies.

```console
$ yay -Yc
```

## Disable Tracker

```console
$ systemctl --user mask tracker-extract-3.service tracker-miner-fs-3.service tracker-miner-rss-3.service tracker-writeback-3.service tracker-xdg-portal-3.service tracker-miner-fs-control-3.service
$ tracker3 reset -s -r
$ sudo reboot
```

## Improve GTK4 font rendering

Add the following to `~/.config/gtk-4.0/settings.ini`

```ini
[Settings]
gtk-hint-font-metrics=1
```

## Software

### Virtual Machines

```console
$ yay -Syu virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft
```

```console
$ sudo systemctl enable libvirtd.service
$ sudo systemctl start libvirtd.service
```

```console
$ sudo usermod -aG libvirt $(whoami)
```

```console
$ sudo reboot
```

See:

* https://wiki.archlinux.org/title/libvirt
* https://wiki.archlinux.org/title/KVM
* https://wiki.archlinux.org/title/QEMU

### Docker (Podman)

```console
$ yay -Syu podman-desktop
```

### Gnome Browser Connector

```console
$ yay -Syu gnome-browser-connector
```

### Gnome Shell Extensions

* https://extensions.gnome.org/extension/2182/noannoyance/
* https://extensions.gnome.org/extension/4269/alphabetical-app-grid/

### Flatpak

```console
$ yay flatpak
$ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Software

### Amberol

```console
$ flatpak install flathub io.bassi.Amberol
```

### Beets Music

```console
$ yay -Syu python-requests beets
```

```console
$ mkdir -p ~/.config/beets
$ cat > ~/.config/beets/config.yaml << EOF
directory: ~/Music
library: ~/Music/musiclibrary.db
plugins: fetchart
fetchart:
    auto: yes
EOF
```

```console
$ beet ls
```

### Nicotine+

```console
$ yay -Syu nicotine+
```

### Fonts

```console
$ yay -Syu ttf-fira-code
```

### Amberol

```console
$ flatpak install flathub io.bassi.Amberol
```

### Calibre

```console
$ flatpak install flathub com.calibre_ebook.calibre
```

### GitHub Desktop

```console
$ yay github-desktop-bin
```

### Visual Studio Code

```console
$ yay visual-studio-code-bin
```

### Menu Editor

```console
$ yay menulibre
```

### Telegram

```console
$ flatpak install flathub org.telegram.desktop
```
