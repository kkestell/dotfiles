# Arch

## Fix Gnome Shell

### Disable Tracker

```console
$ systemctl --user mask tracker-extract-3.service tracker-miner-fs-3.service tracker-miner-rss-3.service tracker-writeback-3.service tracker-xdg-portal-3.service tracker-miner-fs-control-3.service
```

```console
$ tracker3 reset -s -r
```

```console
$ sudo reboot
```

### Improve GTK4 font rendering

Add the following to `~/.config/gtk-4.0/settings.ini`:

```ini
[Settings]
gtk-hint-font-metrics=1
```

### Extensions

Install Gnome Browser Connector first:

```console
$ yay -Sy gnome-browser-connector
```

Then install the following extensions:

* https://extensions.gnome.org/extension/2182/noannoyance/
* https://extensions.gnome.org/extension/4269/alphabetical-app-grid/

## NFS Shares

```text
//NAS/Archive   /home/kyle/nas/archive   cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Books     /home/kyle/nas/books     cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Documents /home/kyle/nas/documents cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Music     /home/kyle/nas/music     cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Photos    /home/kyle/nas/photos    cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Projects  /home/kyle/nas/projects  cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Roms      /home/kyle/nas/roms      cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Unsorted  /home/kyle/nas/unsorted  cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
//NAS/Videos    /home/kyle/nas/videos    cifs _netdev,nofail,username=kyle,password=[REDACTED],workgroup=WORKGROUP,iocharset=utf8,uid=kyle,gid=kyle 0 0
```

```console
$ mkdir -p ~/nas/{archive,books,documents,music,photos,projects,roms,unsorted,videos}
```

```console
$ sudo systemctl daemon-reload
```

```console
$ sudo mount -a
```

## Printing

Brother HL-L2340D

```console
$ yay -Sy cups cups-pdf brlaser
```

```console
$ sudo systemctl enable cups.socket
$ sudo systemctl enable cups.service
$ sudo systemctl start cups.socket
```

## Software

### Docker

```console
$ yay -Sy docker docker-compose
```

```console
$ sudo systemctl enable docker
$ sudo systemctl start docker
```

```console
$ sudo usermod -aG docker $(whoami)
$ sudo reboot
```

### Virtual Machines

```console
$ yay -Sy virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft
```

```console
$ sudo systemctl enable libvirtd.service
$ sudo systemctl start libvirtd.service
```

```console
$ sudo usermod -aG libvirt $(whoami)
```

```console
$ sudo virsh net-start default
```

```console
$ sudo reboot
```

See:

* https://wiki.archlinux.org/title/libvirt
* https://wiki.archlinux.org/title/KVM
* https://wiki.archlinux.org/title/QEMU

### Pandoc

```console
$ yay -Sy pandoc-bin texlive-core
```

```console
$ pandoc test.md --pdf-engine=xelatex -o test.pdf
$ pandoc test.md --pdf-engine=xelatex --variable "geometry=margin=0.75in" --highlight-style=monochrome -o test.pdf
```

See: https://pandoc.org/demos.html

### Beets Music

```console
$ yay -Sy python-requests beets
```

```console
$ mkdir -p ~/.config/beets
```

`~/.config/beets/config.yaml`:

```yaml
directory: ~/nas/music
library: ~/nas/music/musiclibrary.db
plugins: fetchart
fetchart:
    auto: yes
```

```console
$ beet stats
```

### Nicotine+

```console
$ yay -Sy nicotine+
```

### Fonts

```console
$ yay -Sy ttf-fira-code
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
