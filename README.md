# Before Install

This is my own `wayfire` based dotfiles.So make sure you have at least skimmed throuth my [installation process](https://github.com/ausosawx/archlinux-docs) to see whether satisfying some basic requirements.

## Fast Recovery
In the `./pkglist/scripts/` there is a `install.sh` script,which can help you complele the most of work.

So just copy the `install.sh`, and `pkglist_newest.txt` , `pkglist_all_newest.txt` in its parent directory somewhere and run the `install.sh`.

* But I still recommend finishing the `Priority` part of the `Manual Recovery` section first,because a `good network` is needed.You know what I mean.

Wait for it to end.

**But there is still something else you may need or want to set.**

* <a href = "#check nvidia">check nvidia </a>
* <a href = "#ssh"> set ssh </a>
* <a href = "#pacman"> set pacman </a>
* <a href = "#vscodium-bin"> vscodium-bin </a>
* <a href = "#waybar"> waybar </a>

## Manual Recovery
### Priority

Let me say you have just finished the basic installation and now in the tty.

I recommand installing `paru` first as it can directly install packages from `AUR` and more conveniently.
```bash
sudo pacman -S paru
```

It is better to operate in a graphical interface(`wayfire` for me).So let's do it now.

Install a terminal.
```bash
paru -S kitty
```

Install `wayfire`
```bash
paru -S wayfire-lily-git
paru -S polkit                  # polkit as dependency otherwise wayfire cannot open, polkit-gnome needs polkit
```

Before entering `wayfire`, you must change the default terminal as `wayfire` use `alacritty` or you cannot open any terminal.
```bash
mkdir ~/.config
cp /usr/share/wayfire.ini ~/.config/

change the terminal to kitty
```
now you can type `wayfire` in `tty` to enter! Then you can install all the packages needed.

before install everything, I recommend setting up `proxy` first as some packages need `scientific network`.`clash` is a good option.

```bash
paru -S clash-verge
paru -S clash-meta

# tun mode need some rights
sudo setcap cap_net_bind_service,cap_net_admin=+ep /usr/bin/clash-meta
# set up clash-verge
* open `Tun Mode`
* `Clash Field all checked except 'redir-port`
```

### Start
```bash

# Browser 
paru -S firefox-beta-bin
paru -S pipewire pipewire-pulse lib32-pipewire pipewire-alsa pipewire-jack      ## firefox needs

# fonts
paru -S noto-fonts noto-fonts-cjk noto-fonts-emoji
paru -S ttf-sourcecodepro-nerd

# tutanoto email desktop
paru -S tutanota-desktop

# passwd manager
paru -S bitwarden

# bluetooth
paru -S blueberry
paru -S bluez-utils

# ssh
paru -S openssh

# rank mirrors
paru -S pacman-contrib

# input
paru -S fcitx5-im fcitx5-rime                           # Chinese
paru -S fcitx5-anthy                                    # Japanese

# process
paru -S xorg-xkill                                      # kill process
paru -S htop                                            # process viewer
paru -S btop                                            # process viewer

# useful tools
paru -S neofetch                                        # system info
paru -S aria2 yt-dlp wget                               # download tools
paru -S cava                                            # interesting sound present
paru -S man-db                                          # help tool
paru -S swayidle                                        # Inhibitor
paru -S light                                           # adjust backlight
paru -S swaylock                                        # lock screen
paru -S wlogout                                         # log out
paru -S wl-clipboard                                    # wayland cut
paru -S mako                                            # notifications
paru -S kanshi                                          # screen adjust
paru -S gnome-keyring                                   # system keychain to encrypt sensitive details such as credentials and alarms
paru -S rofi                                            # launcher
paru -S lazygit                                         # git
paru -S expac                                           # list packages installation info
paru -S cmake                                           # compilation
paru -S wxmaxima gnuplot                                # maxima graphical interface,gnuplot for plot capabilities

# file related
paru -S ranger                                          # ranger
paru -S bat                                             # preview
paru -S python-pillow                                   # ranger preview pictures
paru -S highlight atool ffmpegthumbnailer               # ranger need

paru -S evince                                          # evince
paru -S zathura zathura-pdf-poppler poppler-data        # pdf reader

paru -S thunar raw-thumbnailer thunar-archive-plugin    # thunar
paru -S thunar-volman gvfs-mtp gvfs tumbler             # thunar options
paru -S file-roller  polkit-gnome                       # thunar options
paru -S p7zip                                           # thunar options

paru -S fzf fd                                          # fuzzy search

paru -S zotero-bin                                      # research

# editor
paru -S vscodium-bin                                    # vscode open source
paru -S libreoffice-fresh-zh-cn  jdk17-openjdk          # work tools
paru -S qtcreator lldb                                  # nice editor
paru -S qt6 qt6-doc qt6-examples                        # qt6
paru -S dbeaver                                         # database manager

# shell
paru -S zsh                                             # shell
paru -S inetutils                                       # provide hostname command

# video related
paru -S obs-studio qt5-wayland                          # obs
paru -S xdg-desktop-portal-wlr                          # obs need
paru -S mpv-git                                         # video player
paru -Sevlc-git                                         # video player

# pictures related
paru -S swaybg-git                                      # background
paru -S slurp grim                                      # capture
paru -S imv                                             # picture reader
paru -S nomacs qt5-imageformats                         # picture view

# music related
paru -S mpd ncmpcpp mpc                                 # music player
paru -S spotify                                         # music player

# bar
paru -S waybar python-gobject playerctl python-pyquery  # waybar 
paru -S otf-font-awesome                                # waybar options
paru -S pavucontrol                                     # volume control
paru -S network-manager-applet                          # network tray

# theme
paru -S vimix-gtk-themes-git vimix-icon-theme           # theme
paru -S graphite-cursor-theme-git                       # cursor style

# latex
paru -S texlive-most texlive-lang

# communication
paru -S telegram-desktop

# else
paru -S gtk4
```

### Graphics
refer to [archwiki](https://wiki.archlinux.org/)
```bash
intel:
paru -S lib32-mesa vulkan-intel lib32-vulkan-intel mesa-utils
paru -S intel-media-driver (firefox hardware video acceleration)

nvidia:
paru -S nvidia nvidia-settings lib32-nvidia-utils
```
remember to reboot to let it take effect.

under wayland I have `alias prime-run = GBM_BACKEND=nvidia-drm __GLX_VENDOR_LIBRARY_NAME=nvidia`,so there is no need to install prime-run as it is just the similar scripts.

* <div id="check nvidia">check nvidia</div>
```bash
GBM_BACKEND=nvidia-drm __GLX_VENDOR_LIBRARY_NAME=nvidia glxgears
nvidia-smi(check if glxgears exists)
```

### Neovim
see [neovim](https://github.com/ausosawx/dotfiles/tree/master/nvim) for requirements.

### Explanation About The Packages

#### <div id="ssh">ssh</div>
```bash
ssh-keygen -t rsa -C "your_email@example.com"               # ssh-key
cat ~/.ssh/id_rsa.pub                                       # add to your github 
```

#### bluetooth
```bash
sudo systemctl enable --now bluetooth
sudo gpasswd -a $USER lp
```
Before using a bluetooth device, check if it is disabled by rfkill.

#### <div id="pacman">pacman</div>
To make paru more beautiful,recommend opening the `Color` option
```bash
sudo nvim /etc/pacman.conf
```
Then uncomment the `Color` option

#### thunar
* In order to mount the windows disk,you must dowmload a [Authentication agents](https://wiki.archlinux.org/title/Polkit), in my case, I install polkit-gnome as in the wayfire.ini, I let it autostart with wayfire.

#### <div id="waybar">waybar</div>
Pay attention to verifying that the scripts under the waybar are valid and whether some packages are lacking

#### group
```bash
sudo gpasswd -a $USER input                   # add to input
```

#### <div id="vscodium-bin">vscodium-bin</div>
Install a sync plugin to sync(`Settings Sync`)

#### mpd
```bash
systemctl enable --now --user mpd       # autostart
mkdir ~/Music                           # must
```

#### light
to let light to adjust backlight, you need to add user to `video group` and `reboot`
```bash
sudo gpasswd -a $USER video
```

# Install
Clone the repo to a dir(maybe ~/.dotfile),and then run install
```bash
git clone git@github.com:thedawnboy/dotfiles.git ~/.dotfiles/
cd .dotfiles
./install
```

**Reboot to enjoy your arch journey!**


# More things
Obviously,there are more things to do to make the system more multi-functional and efficient.

So there is another file to take notes of some important settings,problems and so on.

Refer to [after_install.md](https://github.com/ausosawx/archlinux-docs/blob/master/after_install.md) for more info.
