# Debian 11

```console
$ su -
# usermod -aG kyle sudo
# reboot
```

```console
$ sudo apt install nfs-common
```

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
$ sudo mount -a
```

## Flatpak

```console
$ sudo apt install flatpak gnome-software-plugin-flatpak
$ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Software

### Amberol

```console
$ flatpak install flathub io.bassi.Amberol
```

### Beets Music

```console
$ sudo apt install beets
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

### Git

```console
$ sudo apt install git
```

### GitHub Desktop

See: https://github.com/shiftkey/desktop

```console
$ wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
$ sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
$ sudo apt update && sudo apt install github-desktop
```

### Visual Studio Code

See: https://code.visualstudio.com/docs/setup/linux

```console
$ wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
$ sudo apt install ./vscode.deb
$ rm vscode.deb
```
