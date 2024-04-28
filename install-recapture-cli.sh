#!/bin/bash

# On Arch to find the correct URL for our package we use:
# pacman -Sddp gst-plugins-good
# pacman -Sddp gst-plugins-bad
# pacman -Sddp gst-plugin-pipewire
# pacman -Sddp gstreamer-vaapi
# pacman -Sddp gst-plugins-bad-libs

# Check if the download URL exists.
GOOD_PLUGIN_URL="https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-rel/os/x86_64/gst-plugins-good-1.20.4-1-x86_64.pkg.tar.zst"
if wget --timeout=3 --tries=3 --spider ${GOOD_PLUGIN_URL} 2>/dev/null; 
 then
    echo "OK! Gstreamer GOOD Plugin file exists at ${GOOD_PLUGIN_URL}"
 else
    echo "ERROR! Gstreamer GOOD Plugin file at URL: ${GOOD_PLUGIN_URL} is not found! Instalation will be aborted!"
    exit 1
fi

# Check if the download URL exists.
BAD_PLUGIN_URL="https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-3.5/os/x86_64/gst-plugins-bad-1.22.3-6-x86_64.pkg.tar.zst"
if wget --timeout=3 --tries=3 --spider ${BAD_PLUGIN_URL} 2>/dev/null; 
 then
    echo "OK! Gstreamer BAD Plugin file exists at ${BAD_PLUGIN_URL}"
 else
    echo "ERROR! Gstreamer BAD Plugin file at URL: ${BAD_PLUGIN_URL} is not found! Instalation will be aborted!"
    exit 1
fi

# Check if the download URL exists.
PIPEWIRE_PLUGIN_URL="https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.5/os/x86_64/gst-plugin-pipewire-1:0.3.62.2.dv-2-x86_64.pkg.tar.zst"
if wget --timeout=3 --tries=3 --spider ${PIPEWIRE_PLUGIN_URL} 2>/dev/null; 
 then
    echo "OK! Gstreamer PIPEWIRE Plugin file exists at ${PIPEWIRE_PLUGIN_URL}"
 else
    echo "ERROR! Gstreamer PIPEWIRE Plugin file at URL: ${PIPEWIRE_PLUGIN_URL} is not found! Instalation will be aborted!"
    exit 1
fi

# Check if the download URL exists.
VAAPI_PLUGIN_URL="https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-3.5/os/x86_64/gstreamer-vaapi-1.22.3-6-x86_64.pkg.tar.zst"
if wget --timeout=3 --tries=3 --spider ${VAAPI_PLUGIN_URL} 2>/dev/null; 
 then
    echo "OK! Gstreamer VAAPI Plugin file exists at ${VAAPI_PLUGIN_URL}"
 else
    echo "ERROR! Gstreamer VAAPI Plugin file at URL: ${VAAPI_PLUGIN_URL} is not found! Instalation will be aborted!"
    exit 1
fi

# Check if the download URL exists.
BAD_LIBS_PLUGIN_URL="https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-3.5/os/x86_64/gst-plugins-bad-libs-1.22.3-6-x86_64.pkg.tar.zst"
if wget --timeout=3 --tries=3 --spider ${BAD_LIBS_PLUGIN_URL} 2>/dev/null; 
 then
    echo "OK! Gstreamer BAD_LIBS Plugin file exists at ${BAD_LIBS_PLUGIN_URL}"
 else
    echo "ERROR! Gstreamer BAD_LIBS Plugin file at URL: ${BAD_LIBS_PLUGIN_URL} is not found! Instalation will be aborted!"
    exit 1
fi

# Remove previously created directory if exists.
echo "Removing existing installation directory, if it was previously created."
sleep 1
rm -rf $HOME/.local/recapture &>/dev/null

# Create plugin instalation directory
echo "We need to create the instalation directory."
sleep 1
mkdir -p $HOME/.local/recapture/libs
mkdir -p $HOME/.local/recapture/plugins/good
mkdir -p $HOME/.local/recapture/plugins/bad
mkdir -p $HOME/.local/recapture/plugins/vaapi
mkdir -p $HOME/.local/recapture/plugins/pipewire

echo "Installing the gstreamer plugins and scripts"
sleep 1
# Lets start in /tmp directory                       
cd /tmp  

# For the screen recording to work in Desktop mode, we require gstreamer good plugin libgstximagesrc.so
# Lets download it form steamos extra-rel repo
mkdir -p /tmp/recapture_dl_dir/plugin/good
	wget \
		-O recapture_dl_dir/gst-plugins-good.pkg.tar.zst \
		https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-rel/os/x86_64/gst-plugins-good-1.20.4-1-x86_64.pkg.tar.zst
	tar --use-compress-program=unzstd -xf recapture_dl_dir/gst-plugins-good.pkg.tar.zst -C recapture_dl_dir/plugin/good
	cp recapture_dl_dir/plugin/good/usr/lib/gstreamer-1.0/* $HOME/.local/recapture/plugins/good
	
mkdir -p /tmp/recapture_dl_dir/plugin/bad
	wget \
		-O recapture_dl_dir/gst-plugins-bad.pkg.tar.zst \
		https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-3.5/os/x86_64/gst-plugins-bad-1.22.3-6-x86_64.pkg.tar.zst
	tar --use-compress-program=unzstd -xf recapture_dl_dir/gst-plugins-bad.pkg.tar.zst -C recapture_dl_dir/plugin/bad
	cp recapture_dl_dir/plugin/bad/usr/lib/gstreamer-1.0/* $HOME/.local/recapture/plugins/bad
	
mkdir -p /tmp/recapture_dl_dir/plugin/pipewire
	wget \
		-O recapture_dl_dir/gst-plugins-pipewire.pkg.tar.zst \
		https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-3.5/os/x86_64/gst-plugin-pipewire-1:0.3.62.2.dv-2-x86_64.pkg.tar.zst
	tar --use-compress-program=unzstd -xf recapture_dl_dir/gst-plugins-pipewire.pkg.tar.zst -C recapture_dl_dir/plugin/pipewire
	cp recapture_dl_dir/plugin/pipewire/usr/lib/gstreamer-1.0/* $HOME/.local/recapture/plugins/pipewire
	
mkdir -p /tmp/recapture_dl_dir/lib/bad-libs
	wget \
		-O recapture_dl_dir/gst-plugins-bad-libs.pkg.tar.zst \
		https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-3.5/os/x86_64/gst-plugins-bad-libs-1.22.3-6-x86_64.pkg.tar.zst
	tar --use-compress-program=unzstd -xf recapture_dl_dir/gst-plugins-bad-libs.pkg.tar.zst -C recapture_dl_dir/lib/bad-libs
	cp recapture_dl_dir/lib/bad-libs/usr/lib/* $HOME/.local/recapture/libs
	cp recapture_dl_dir/lib/bad-libs/usr/lib/gstreamer-1.0/* $HOME/.local/recapture/plugins/bad
	
mkdir -p /tmp/recapture_dl_dir/plugin/vaapi
	wget \
		-O recapture_dl_dir/gst-plugins-vaapi.pkg.tar.zst \
		https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-3.5/os/x86_64/gstreamer-vaapi-1.22.3-6-x86_64.pkg.tar.zst
	tar --use-compress-program=unzstd -xf recapture_dl_dir/gst-plugins-vaapi.pkg.tar.zst -C recapture_dl_dir/plugin/vaapi
	cp recapture_dl_dir/plugin/vaapi/usr/lib/gstreamer-1.0/* $HOME/.local/recapture/plugins/vaapi

# Download Recapture CLI wrapper
wget -O recapture_dl_dir/recapture-cli-wrapper.sh \
        https://raw.githubusercontent.com/m-rzb/Screen-recorder-for-steamdeck/main/recapture-cli-wrapper.sh
        
# Move bash script to instalation directory
mv recapture_dl_dir/recapture-cli-wrapper.sh $HOME/.local/recapture/recapture-cli-wrapper.sh

# Make bash script executable
chmod +x $HOME/.local/recapture/recapture-cli-wrapper.sh

# Removing previously created Desktop icon
rm -rf $HOME/Desktop/Recapture.desktop 2>/dev/null

sleep 3
# Create a Desktop icon
echo "Creating a Desktop Icon"
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Recapture
Exec=bash $HOME/.local/recapture/recapture-cli-wrapper.sh
Icon=media-record-symbolic
StartupNotify=false
Terminal=false
Type=Application' > $HOME/Desktop/Recapture.desktop
chmod +x $HOME/Desktop/Recapture.desktop

# Removing previously created Start Menu Icon
rm -rf $HOME/.local/share/applications/Recapture.desktop 2>/dev/null

sleep 3
# # Create Start Menu Icon
echo "Creating a Start Menu Icon"
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Recapture
Exec=bash $HOME/.local/recapture/recapture-cli-wrapper.sh
Icon=media-record-symbolic
StartupNotify=false
Terminal=false
Type=Application' > $HOME/.local/share/applications/Recapture.desktop
chmod +x $HOME/.local/share/applications/Recapture.desktop

update-desktop-database ~/.local/share/applications

sleep 3
# Remove downloaded files from /tmp
echo "Removing downloaded archives. we do not require them anymore."
rm -rf /tmp/recapture_dl_dir 


echo "You can now close the terminal window by using CTRL+C or ENTER"
# exec bash
read -rn1

sleep 10
