#! /bin/bash

# To Do: Install packages from the list, while not reinstalling previously installed packages that are already up-to-date

# For safety, here I let it install all packages from official repository and then install from others(such as AUR)

# Before everything starts,you'd better install `paru` first to avoid some problems
echo "                  "
echo "Install paru first"
echo "                  "
sudo pacman -S --needed paru

# decide where to find the pkglist_newest.txt
echo "** Please input the parent directory path of pkglist_newest.txt or another name.Such as .. and pkglist_newest.txt"
echo "** Relative or absolute path both ok"
echo "** Do not add / in the end of Path"
echo "                                "
echo -n "Path: "
read dirpath
echo -n "Filename: "
read filename
pkglist=${dirpath}/${filename}


# official
echo "                                  "
echo "**********************************"
echo "Ready to install official packages"
echo "**********************************"
echo "                                  "

paru -S --needed $(grep -Fxf $pkglist <(pacman -Slq))

if [ $? -ne 0 ]; then
    echo "Failed , please try again"
    exit
else
    echo "                                        "
    echo "****************************************"
    echo "Official packages successfully installed"
    echo "****************************************"
    echo "                                        "
fi


# foreign
echo "                                 "
echo "*********************************"
echo "Ready to install foreign packages"
echo "*********************************"
echo "                                 "

paru -S --needed $(grep -Fxvf <(pacman -Slq) $pkglist)

if [ $? -ne 0 ]; then
    echo "Failed , please try again"
    exit
else
    echo "                                        "
    echo "****************************************"
    echo "Foreign packages successfully installed"
    echo "****************************************"
    echo "                                        "
fi

# if you don't care,you can comment the above lines except paru installation , and uncomment below
##  echo "** Please input the parent directory path of pkglist_all_newest.txt or another name.Such as .. and pkglist_all_newest.txt"
##  echo "** Relative or absolute path both ok"
##  echo "** Do not add / in the end of Path"
##  echo "                                "
##  echo -n "Path: "
##  read dirpath
##  echo -n "Filename: "
##  read filename
##  pkglist=${dirpath}/${filename}
##  paru -S --needed - < $pkglist
##  if [ $? -ne 0 ]; then
##      echo "Failed , please try again"
##      exit
##  else
##      echo "                                   "
##      echo "***********************************"
##      echo "All packages successfully installed"
##      echo "***********************************"
##      echo "                                   "
##  fi


## make sure the installed packages of the system match the list and remove all the packages that are not mentioned in it
while true
do
    read -r -p "Do you want to remove all the packages that are not mentioned in the list [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
            echo "                                        "
            echo "****************************************"
            echo "Ready to uninstall the unneeded packages"
            echo "****************************************"
            echo "                                        "

            echo "** Please input the parent directory path of pkglist_all_newest.txt or another name.Such as .. and pkglist_all_newest.txt"
            echo "** Relative or absolute path both ok"
            echo "** Do not add / in the end of Path"
            echo "                                "
            echo -n "Path: "
            read dirpath
            echo -n "Filename: "
            read filename
            allpkglist=${dirpath}/${filename}
            remove_list=`grep -Fxvf $allpkglist <(paru -Qq)`

            if [ ! -n "$remove_list" ];then
                echo "                         "
                echo "No packasges need removed"
                echo "                         "
            else
                paru -Rsc $remove_list
            fi
            break
            ;;
        [nN][oO]|[nN])
            break;
            ;;

        *)
            echo "                 "
            echo "Invalid input ..."
            echo "                 "
            ;;
    esac
done


# systemctl
echo "                       "
echo "***********************"
echo "Systemctl config starts"
echo "***********************"
echo "                       "

sudo systemctl enable --now bluetooth
systemctl enable --now --user mpd

# rustup
rustup default stable

# change default shell
echo "                    "
echo "********************"
echo "Change default shell"
echo "********************"
echo "                    "

if [ $(echo $SHELL) != "/usr/bin/zsh" ];then
    chsh -s /usr/bin/zsh
fi


# mpd needs
echo "                             "
echo "*****************************"
echo "Make Music and Scrennshot Dir"
echo "*****************************"
echo "                             "

MUSIC_DIR="$HOME/Music"
SCREENSHOT_DIR="$HOME/Pictures/screenshot"
if [ ! -d "$MUSIC_DIR" ]; then
  mkdir $MUSIC_DIR
fi

if [ ! -d "$SCREENSHOT_DIR" ]; then
        mkdir -p $SCREENSHOT_DIR
fi


# groups needed to join
echo "                        "
echo "************************"
echo "Add user $USER to groups"
echo "************************"
echo "                        "

sudo gpasswd -a $USER video
sudo gpasswd -a $USER lp
sudo gpasswd -a $USER input

echo "                        "


# some questions
bool=

echo "              "

while true
do
    read -r -p "Are you the owner of the repository and already setting the ssh? [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
            bool=true
            break
            ;;
        [nN][oO]|[nN])
            bool=false
            break;
            ;;

        *)
            echo "                 "
            echo "Invalid input ..."
            ;;
    esac
done

echo "            "

# clone archlinux-docs
while true
do
    read -r -p "Do you want to clone the archlinux-docs?" input

    case $input in
        [yY][eE][sS]|[yY])
            echo "                    "
            echo "********************"
            echo "Clone archlinux-docs"
            echo "********************"
            echo "                    "

            ARCHDOC_DIR="$HOME/Data/archlinux-docs"

            if [ -d "${ARCHDOC_DIR}" ]; then
                rm -rf ${ARCHDOC_DIR}
            fi

            if $bool;then
                git clone git@github.com:ausosawx/archlinux-docs.git ${ARCHDOC_DIR}
            else
                git clone https://github.com/ausosawx/archlinux-docs.git ${ARCHDOC_DIR}
            fi

            break
            ;;
        [nN][oO]|[nN])
            echo "               "
            break;
            ;;

        *)
            echo "                 "
            echo "Invalid input ..."
            echo "                 "
            ;;
    esac
done


# clone dotfiles
echo "              "
echo "**************"
echo "Clone dotfiles"
echo "**************"
echo "              "

DOT_DIR="$HOME/.dotfiles"

if [ -d "${DOT_DIR}" ]; then
    rm -rf ${DOT_DIR}
fi

if $bool;then
    git clone git@github.com:ausosawx/dotfiles.git ${DOT_DIR}
else
    git clone https://github.com/ausosawx/dotfiles.git ${DOT_DIR}
fi

echo "                                                      "

# confirm install
if [ $? -ne 0 ]; then
    echo "Failed , please make sure you have cloned the dotfiles"
    exit
else
    while true
    do
        read -r -p "Are you sure to install? [Y/n] " input

        case $input in
            [yY][eE][sS]|[yY])
                echo "                "
                cd ${DOT_DIR}
                ./install
                break
                ;;
            [nN][oO]|[nN])
                exit 1
                ;;

            *)
                echo "                 "
                echo "Invalid input ..."
                echo "                 "
                ;;
        esac
    done
fi

echo "                                                      "

# confirm reboot to take effect
while true
do
    read -r -p "Reboot now to take effect? [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
            reboot
            exit 1
            ;;

        [nN][oO]|[nN])
            exit 1
            ;;

        *)
            echo "                 "
            echo "Invalid input ..."
            echo "                 "
            ;;
    esac
done
