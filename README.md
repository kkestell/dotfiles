# Debian 12

## Mount home directory

Add the following to `/etc/fstab`:

```text
UUID=1bf423c2-d3fc-42b3-a894-05057b929b76 /home/kyle ext4 defaults 0 0
```

Reload systemd:

```console
sudo systemctl daemon-reload
```

Reboot:

```console
sudo reboot
```

## Network Shares

Install `cifs-utils`:

```console
sudo apt install cifs-utils
```

Add the following to `/etc/fstab`:

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

Create mount points:

```console
mkdir -p ~/nas/{archive,books,documents,music,photos,projects,roms,unsorted,videos}
```

Reload systemd:

```console
sudo systemctl daemon-reload
```

Mount:

```console
sudo mount -a
```

## Fix Gnome Shell

### Disable Tracker

```console
systemctl --user mask tracker-extract-3.service tracker-miner-fs-3.service tracker-miner-rss-3.service tracker-writeback-3.service tracker-xdg-portal-3.service tracker-miner-fs-control-3.service
```

```console
tracker3 reset -s -r
```

```console
sudo reboot
```

### Improve GTK4 font rendering

Add the following to `~/.config/gtk-4.0/settings.ini`:

```ini
[Settings]
gtk-hint-font-metrics=1
```

### Shell Extensions

* https://extensions.gnome.org/extension/2182/noannoyance/
* https://extensions.gnome.org/extension/4269/alphabetical-app-grid/

## Printing

Brother HL-L2340D

```console
sudo apt install cups cups-pdf printer-driver-brlaser
```

```console
sudo systemctl enable cups.socket
sudo systemctl enable cups.service
sudo systemctl start cups.socket
```

## Backup

See: [https://github.com/kkestell/backup](https://github.com/kkestell/backup)

## Development

### General

```console
sudo apt install build-essential clang
```

### Git

Install `git`:

```console
sudo apt install git
```

Configure username and email:

```console
git config --global user.name "[REDACTED]"
git config --global user.email "[REDACTED]"
```

### .NET

```console
cd ~/Downloads
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
```

```console
sudo chmod +x ./dotnet-install.sh
```

```console
./dotnet-install.sh --channel 7.0
```

```console
echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc
echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc
```

#### Rider

Download tarball from [https://www.jetbrains.com/rider/download/](https://www.jetbrains.com/rider/download/).

Extract to `~/.local/bin`.

```console
tar -xzf JetBrains.Rider-2023.1.2.tar.gz -C ~/.local/bin
```

Use `Tools` → `Create Desktop Entry` to create a desktop entry.

#### LLVM 15

```console 
deb http://apt.llvm.org/buster/ llvm-toolchain-buster-15 main
deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster-15 main
```

## Software

### Flatpak

```console
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

#### Amberol

```console
flatpak install flathub io.bassi.Amberol
```

#### Calibre

```console
flatpak install flathub com.calibre_ebook.calibre
```

### Docker

See: https://docs.docker.com/engine/install/debian/#install-using-the-repository

```console
sudo usermod -aG docker $(whoami)
sudo reboot
```

### Virtual Machines

```console
yay -Sy virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft
```

```console
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
```

```console
sudo usermod -aG libvirt $(whoami)
```

```console
sudo virsh net-start default
```

```console
sudo reboot
```

See:

* https://wiki.archlinux.org/title/libvirt
* https://wiki.archlinux.org/title/KVM
* https://wiki.archlinux.org/title/QEMU

### Pandoc

```console
sudo apt install pandoc texlive-full
```

```console
pandoc test.md --pdf-engine=xelatex -o test.pdf
pandoc test.md --pdf-engine=xelatex --variable "geometry=margin=0.75in" --highlight-style=monochrome -o test.pdf
```

See: https://pandoc.org/demos.html

### Beets Music

```console
yay -Sy python-requests beets
```

```console
mkdir -p ~/.config/beets
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
beet stats
```

### Nicotine+

```console
yay -Sy nicotine+
```

### Fonts

```console
sudo apt install fonts-firacode
```

### GitHub Desktop

See: https://github.com/shiftkey/desktop

```console
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
```

```console
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
```

```console
sudo apt update && sudo apt install github-desktop
```


### Visual Studio Code

```console
yay visual-studio-code-bin
```

### Menu Editor

```console
yay menulibre
```

### Telegram

```console
flatpak install flathub org.telegram.desktop
```

### Sticky Notes

```console
flatpak install flathub com.vixalien.sticky
```
