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

```
yay -Yc
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

### Docker (Podman)

```console
$ yay -Syu podman-desktop
```

### Gnome Browser Connector

```console
yay -Syu gnome-browser-connector
```

### Gnome Shell Extensions

* https://extensions.gnome.org/extension/2182/noannoyance/
* https://extensions.gnome.org/extension/4269/alphabetical-app-grid/
* 

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

```
$ yay -Syu ttf-fira-code
```

### Amberol



### Calibre

```console
$ flatpak install flathub com.calibre_ebook.calibre
```

### Docker

#### Engine

See: https://docs.docker.com/engine/install/debian/

```console
$ sudo apt-get update
$ sudo apt-get install ca-certificates curl gnupg lsb-release
```

```console
$ sudo mkdir -m 0755 -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

```console
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```console
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### Desktop

See: https://docs.docker.com/desktop/install/debian/

```console
$ wget -O docker-desktop.deb https://desktop.docker.com/linux/main/amd64/docker-desktop-4.17.0-amd64.deb
$ sudo apt install ./docker-desktop.deb
$ rm docker-desktop.deb
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
