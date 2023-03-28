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
```

```console
$ mkdir -p ~/{Archive,Books,Unsorted,Projects,Roms}
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

### Flatpak

```console
$ yay flatpak
```

```console
$ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

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
$ yay -Sy pandoc-bin texlive-most
```

```console
$ pandoc test.md --pdf-engine=xelatex -o test.pdf
```

```console
$ pandoc -N --variable "geometry=margin=1.2in" --variable mainfont="Palatino" --variable sansfont="Helvetica" --variable monofont="Menlo" --variable fontsize=12pt --variable version=2.0 test.md --include-in-header fancyheaders.tex --pdf-engine=xelatex --toc -o test.pdf
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
directory: ~/Music
library: ~/Music/musiclibrary.db
plugins: fetchart
fetchart:
    auto: yes
```

```console
$ beet ls
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
