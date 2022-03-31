#!/bin/bash
# Finish Setup my inux

#####################################################################
#  ____    ____  __                                                 #
#  \   \  /   / |__| ____ ________    ____    _______ ___  ___      #
#   \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /      #
#    \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /        #
#     \____/   |___||____|  |__|    \_____ / |__|       |_|         #
#                                                                   #
# Victory Linux Install script                               #
# https://github.com/VictoryLinux                                   #
#####################################################################


echo -e "----------------------------------------------------------------"
echo -e "  ____    ____  __                                              "
echo -e "  \   \  /   / |__| ____ ________    ____    _______ ___  ___   "
echo -e "   \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /   "
echo -e "    \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /     "
echo -e "     \____/   |___||____|  |__|    \_____ / |__|       |_|      "
echo -e "                                                                "
echo -e "----------------------------------------------------------------"
echo -e "    ██████╗ ██████╗ ██████╗     █████╗   ██████╗  █████╗        "
echo -e "    ███═══╝ ██════╝ ██    ██╗  ██    ██╗ ██   ██╗██╔══██╗       "
echo -e "    █████╗  █████╗  ██     ██╗██      ██╗██████╔╝███████║       "
echo -e "    ███══╝  ██═══╝  ██    ██╔╝ ██    ██╔╝██   ██║██║  ██║       "
echo -e "    ███╗    ██████╗ ██████╔═╝   ██████╔╝ ██   ██║██║  ██║       "
echo -e "    ╚══╝    ╚═════╝ ╚═════╝     ╚═════╝  ╚═╝  ╚═╝╚═╝  ╚═╝       "
echo -e "----------------------------------------------------------------"

# Make sure each command executes properly
check_exit_status() {

	if [ $? -eq 0 ]
	then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Update Failed! Check the errors and try again"
		echo
		
		read -p "The last command exited with an error. Exit script? (y/n) " answer

            if [ "$answer" == "y" ]
            then
                exit 1
            fi
	fi
}

function greeting() {
	clear
	
    echo "+-------------------------------------------------------------------------+"
echo "|-------   Hello, $USER. Let's setup your Victory-Edition.  -------|"
echo "+-------------------------------------------------------------------------+"
echo -e "----------------------------------------------------------------"
echo -e "  ____    ____  __                                              "
echo -e "  \   \  /   / |__| ____ ________    ____    _______ ___  ___   "
echo -e "   \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /   "
echo -e "    \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /     "
echo -e "     \____/   |___||____|  |__|    \_____ / |__|       |_|      "
echo -e "                                                                "
echo -e "----------------------------------------------------------------"
echo -e "    ██████╗ ██████╗ ██████╗     █████╗   ██████╗  █████╗        "
echo -e "    ███═══╝ ██════╝ ██    ██╗  ██    ██╗ ██   ██╗██╔══██╗       "
echo -e "    █████╗  █████╗  ██     ██╗██      ██╗██████╔╝███████║       "
echo -e "    ███══╝  ██═══╝  ██    ██╔╝ ██    ██╔╝██   ██║██║  ██║       "
echo -e "    ███╗    ██████╗ ██████╔═╝   ██████╔╝ ██   ██║██║  ██║       "
echo -e "    ╚══╝    ╚═════╝ ╚═════╝     ╚═════╝  ╚═╝  ╚═╝╚═╝  ╚═╝       "
echo -e "----------------------------------------------------------------"
echo -e " DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK. "
echo -e "----------------------------------------------------------------"

echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "++++++++         This is NOT a silent install        ++++++++"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

	
#	sleep 5s
	echo "ARE YOU READY TO START? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, you are ready to start"
	   echo
	   echo "Starting VictoryFedora install script."
	   echo
	   sleep 3s

	# treat anything else as a negative response
	else

	   echo "You replied $input, you are not ready"
	   echo
	   exit 1

fi

	echo
	
	check_exit_status
}

# Enable root user
function root() {

	echo "############################"
	echo "|    Enabling Root user.   |"
	echo "############################"
	echo
	sleep 6s
	sudo passwd root
	echo
	check_exit_status
}

# Set the Hostname
function hostname() {
	
	echo "############################"
	echo "|     Set the PC Name.     |"
	echo "############################"
	echo
	sleep 6s
	sudo nano /etc/hostname;
	echo
	check_exit_status
}

# GPU 2
function gpu2() {
	# Graphics Drivers find and install
if lspci | grep -E "NVIDIA|GeForce"; then
    sudo dnf install akmod-nvidia
elif lspci | grep -E "Radeon"; then
    echo 'AMD Detected, moving on'
elif lspci | grep -E "Integrated Graphics Controller"; then
    echo 'Intel UHD Detected, moving on'
fi

echo -e "\nDone!\n"
if [ $(whoami) = "root"  ];
then
    useradd -m -G wheel,libvirt -s /bin/bash $username 
	passwd $username
	cp -R /root/VictoryFedora /home/$username/
    chown -R $username: /home/$username/VictoryFedora
	read -p "Please name your machine:" nameofmachine
	echo $nameofmachine > /etc/hostname
else
	echo "You are already a user proceed"
fi
	check_exit_status
}


# Adding RPM Fusion as a repository
function thirdparty() {

	echo "#########################################"
	echo "|     Adding RPM Fusion and Flathub.    |"
	echo "#########################################"
	echo
	sleep 6s
	sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm;
	echo
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	echo
	check_exit_status
}

# Add to DNF config
function mirror() {

	echo "###########################"
	echo "|         Mirrors         |"
	echo "###########################"
	echo
	sleep 6s
	# Set to Fastest Mirror
	sed -i -e 'fastestmirror=True' /etc/dnf/dnf.conf 
	# Add parallel downloading
	sed -i -e 'max_parallel_downloads=10' /etc/dnf/dnf.conf
	# Add Y as default
	sed -i -e '$adefaultyes=True' /etc/dnf/dnf.conf
	echo
	check_exit_status
	
}

# Updating 
function update() {

	echo "###########################"
	echo "|        Updating         |"
	echo "###########################"
	echo
	sleep 6s
	echo	
	sudo dnf update -y;
	echo
	check_exit_status
}

# Removing unwanted pre-installed packages
function debloat() {

	echo "#############################"
	echo "|        Debloating         |"
	echo "#############################"
	echo
	sleep 6s
	sudo dnf -y remove gnome-clocks gnome-maps simple-scan gnome-weather gnome-boxes totem rhythmbox;
	echo
	check_exit_status
}

# Installing Packages
function install() {

	echo "###############################"
	echo "|     Installing Packages.    |"
	echo "###############################"
	echo

sleep 6s

PKGS=(
'alacarte'
'autoconf' # build
'automake' # build
'breeze-cursor-theme'
'celluloid' # video players
'dkms'
'dnf-plugins-core'
'filelight'
'flex'
'fuse3'
'gamemode'
'gcc'
'gimp' # Photo editing
'git'
'gnome-tweak-tool'
'gparted' # partition management
'grub-customizer'
'gwenview'
'gydl'
'gvfs-smb'
'haveged'
'htop'
'inxi'
'kcodecs'
'kernel-devel'
'kmail'
'kmag'
'layer-shell-qt'
'lsof'
'lzop'
'm4'
'make'
'mtools'
'mono-complete'
'nodejs'
'npm'
'ncdu'
'neofetch'
'networkmanager'
'dconf-editor'
'meson'
'onboard'
'java-latest-openjdk.x86_64' # Java 17
'openssh'
'p7zip'
'patch'
'pkgconf'
'powerline-fonts'
'snapper'
'stacer'
'starship'
'swtpm'
'terminator'
'terminus-font'
'timeshift'
'traceroute'
'unrar'
'util-linux-user'
'ufw'
'unzip'
'usbutils'
'variety'
'VirtualBox'
'wireplumber'
'wine'
'winetricks'
'youtube-dl'
#
'chrome-gnome-shell'
'wine-dxvk'
#'gnome-shell-extension-impatience-git'
#'gnome-shell-extension-no-annoyance-git'
'gnome-shell-extension-dash-to-dock'
#'gnome-shell-extension-tiling-assistant'
#'gnome-shell-extension-extensions'
'gnome-shell-extension-caffeine'
'gnome-shell-extension-pop-shell-git'
'gnome-shell-extension-sound-output-device-chooser'
#'gnome-shell-extension-vitals-git'
#'gnome-shell-extension-gnome-ui-tune'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo dnf install "$PKG" -y
done

	sleep 3s
	echo
	# AppimageLauncher
	cd Downloads
	wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
	echo
	sudo rpm -i appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
	echo
	cd ~/
	echo
	# VirtualBox
	systemctl restart vboxdrv
	echo
	sleep 3s
	dnf module install nodejs:15
	echo
	# Brave Browser
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	echo
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	echo
	sudo dnf install brave-browser -y
	echo
	# Github Desktop
	cd Downloads
	echo
    	wget https://github.com/shiftkey/desktop/releases/download/release-2.9.9-linux2/GitHubDesktop-linux-2.9.9-linux2.rpm
	echo
	sudo rpm -i GitHubDesktop-linux-2.9.9-linux2.rpm
    	echo
	# Sound Codecs
	sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
	echo
	sudo dnf install lame\* --exclude=lame-devel
	echo
	sudo dnf group upgrade --with-optional Multimedia
	sleep 3s
	
	# Flatpaks
	flatpak install flathub com.discordapp.Discord -y
	flatpak install flathub org.onlyoffice.desktopeditors -y
	flatpak install flathub com.simplenote.Simplenote -y
	flatpak install flathub com.system76.Popsicle -y
    	flatpak install flathub com.vscodium.codium -y
    	flatpak install flathub com.mattjakeman.ExtensionManager -y
    	flatpak install flathub com.bitwarden.desktop -y
    	flatpak install flathub nl.hjdskes.gcolor3 -y
    	flatpak install flathub com.usebottles.bottles -y
	
	echo
	flatpak remote-add --if-not-exists plex-media-player https://flatpak.knapsu.eu/plex-media-player.flatpakrepo
	flatpak install plex-media-player tv.plex.PlexMediaPlayer -y
	echo
    	cd ~/
	git clone https://github.com/ryanoasis/nerd-fonts
	cd ~/nerd-fonts
	./install.sh FiraCode
	echo
	check_exit_status
}

# Put the wallpaper
function backgrounds() {

	echo "#########################################"
	echo "|     Setting up Favorite Wallpaper.    |"
	echo "#########################################"
	echo
	sleep 6s
	cd ~/
    	git clone https://gitlab.com/dwt1/wallpapers.git

	check_exit_status
}

#
function configs() {
	
	echo "##################################"
	echo "|     Setting Format changes.    |"
	echo "##################################"
	echo
	sleep 6s
   	echo
    	export PATH=$PATH:~/.local/bin
    	cp -r $HOME/VictoryFedora/configs/* $HOME/.config/
    	echo
    	mv $HOME/.config/bashrc $HOME/.config/.bashrc
    	mv $HOME/.config/.bashrc $HOME
    	echo
    	mv $HOME/.config/face $HOME/.config/.face
    	mv $HOME/.config/.face $HOME
    
}

function appearance() {
	cd $HOME/VictoryFedora/
	git clone https://github.com/daniruiz/flat-remix
	git clone https://github.com/daniruiz/flat-remix-gtk
	#mkdir -p ~/.icons && mkdir -p ~/.themes
#	cp -r flat-remix/Flat-Remix* ~/.icons/ && cp -r flat-remix-gtk/themes/Flat-Remix* ~/.themes/
	sudo mv flat-remix/Flat-Remix* /usr/share/icons/ 
	sudo mv flat-remix-gtk/themes/Flat-Remix* /usr/share/themes/
	rm -rf ~/flat-remix flat-remix-gtk
	gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Dark"
	gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue-Dark"
	echo
	gsettings set org.gnome.shell favorite-apps "['brave-browser.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'terminator.desktop', 'com.simplenote.Simplenote.desktop', 'virtualbox.desktop', 'com.vscodium.codium.desktop', 'onboard.desktop']"
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
	gsettings set org.gnome.desktop.interface clock-format '12h'   
	gsettings set org.gnome.desktop.interface cursor-theme 'Breeze'

	check_exit_status
}

#EXTENSIONS
function extensions() {
	gnome-extensions enable caffeine@patapon.info
	gnome-extensions enable dash-to-dock@micxgx.gmail.com
#	gnome-extensions enable impatience@gfxmonk.net
#	gnome-extensions enable noannoyance@daase.net
	gnome-extensions enable pop-shell@system76.com
#	gnome-extensions enable tiling-assistant@leleat-on-github
#	gnome-extensions enable Vitals@CoreCoding.com
	gnome-extensions enable window-list@gnome-shell-extensions.gcampax.github.com
	gnome-extensions enable sound-output-device-chooser@kgshank.net
#	gnome-extensions enable gnome-ui-tune@itstime.tech
#	gnome-extensions enable pamac-updates@manjaro.org
#	gnome-extensions enable taskicons@rliang.github.com

	check_exit_status
}

#GPU
function gpu() {
echo "Nvidia GPU? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, Installing Nvidia Graphics Driver"
	   echo
	   sudo dnf update -y # and reboot if you are not on the latest kernel
	   sudo dnf install akmod-nvidia
	   sleep 3s

	# treat anything else as a negative response
	else

	   echo "You replied $input, you are not ready"
	   echo
	   echo "NOT installing Nvidia Graphics Driver, moving on."
	   sleep 6s

fi

	echo
	
	check_exit_status
}

#GRUB
function grub() {
	cd $HOME/VictoryFedora/grub/
	sudo chmod +x install.sh
	sudo ./install.sh

	check_exit_status
}

# Games
function gmaes() {
	mkdir Games
	echo 
	cd Games
	echo
	# MultiMC
	wget https://files.multimc.org/downloads/mmc-stable-lin64.tar.gz
	echo
	tar -xvzf mmc-stable-lin64.tar.gz
	echo
	rm mmc-stable-lin64.tar.gz
	echo
	# Ascension Wow
	export WINEPREFIX="/home/${USER}/.config/projectascension/WoW"
	echo
	export WINEARCH=win32
	echo
	wget https://download.ascension-patch.gg/update/ascension-launcher-77.AppImage
	echo
	cd ~/
	check_exit_status
}

#
function clean-up() {
	
	echo "##################################"
	echo "|     Cleaning up Left Overs.    |"
	echo "##################################"
	echo
	sleep 6s
	sudo rm -rf /usr/share/backgrounds/gnome
	echo
	sudo rm -rf /usr/share/backgrounds/workstation
	echo
	sudo rm -rf ~/nerd-fonts
    	echo
	check_exit_status
}

# finish
function finish() {
	read -p "Are You ready to restart now? (y/n) " answer 

            if [ "$answer" == "y" ]
            then
            	cecho
		echo "----------------------------------------------------"
		echo "---- VictoryFedora has been installed! ----"
		echo "----------------------------------------------------"
		echo
		check_exit_status
		echo
		echo "Restarting in 15s"
		sleep 15s
                shutdown -r now

            if [ "$answer" == "n" ]
            then
		exit 1

            fi
        fi

}

greeting
root
#hostname
gpu2
thirdparty
update
debloat
install
games
#gpu
backgrounds
configs
appearance
extensions
grub
clean-up
finish
