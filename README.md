# Arch

## Mount home directory

Add the following to `/etc/fstab`:

```text
UUID=1bf423c2-d3fc-42b3-a894-05057b929b76 /home/kyle ext4 defaults 0 0
```

Reboot:

```console
sudo reboot
```

## Network Shares

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

## Wayland Support

```
sudo pacman -Sy plasma-wayland-session
```

## Printing

Brother HL-L2340D

```console
yay -Sy cups cups-pdf brlaser
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

Configure username and email:

```console
git config --global user.name "[REDACTED]"
git config --global user.email "[REDACTED]"
```

### Docker

```console
yay -Sy docker docker-compose
```

```console
sudo systemctl enable docker
sudo systemctl start docker
```

```console
sudo usermod -aG docker $(whoami)
sudo reboot
```

### .NET 7

```console
sudo pacman -Sy dotnet-sdk
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
sudo pacman -Sy llvm
```

## Software

### Flatpak

```console
sudo pacman -Sy flatpak
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

### Pandoc

```console
yay -Sy pandoc-bin texlive-core
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
sudo pacman -Sy nicotine+
```

### Fonts

```console
sudo pacman -Sy ttf-fira-code
```

### GitHub Desktop

```console
yay -Sy github-desktop-bin
```

### Visual Studio Code

```console
yay -Sy visual-studio-code-bin
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

### Express VPN

```console
yay -Sy expressvpn
```

```console
sudo systemctl enable expressvpn
sudo systemctl start expressvpn
```

```console
expressvpn activate
```
