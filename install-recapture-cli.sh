#!/bin/bash
#
#

# Check if the download URL exists.
#RECAPTURE_URL="https://git.sr.ht/~avery/recapture/refs/download/plugin-0.1.3/recapture-0.1.3.tar.gz"
#if wget --spider ${RECAPTURE_URL} 2>/dev/null; 
# then
#    echo "OK! Recapture file exists at ${RECAPTURE_URL}"
# else
#    echo "ERROR! Recapture file at URL: ${RECAPTURE_URL} is not found! Instalation will be aborted!"
#    exit 1
#fi

# On Arch to find the correct URL for our package we use:
# 'pacman -Sup gst-plugins-good'

# Check if the download URL exists.
GOOD_PLUGIN_URL="https://steamdeck-packages.steamos.cloud/archlinux-mirror/extra-rel/os/x86_64/gst-plugins-good-1.20.4-1-x86_64.pkg.tar.zst"
if wget --timeout=3 --tries=3 --spider ${GOOD_PLUGIN_URL} 2>/dev/null; 
 then
    echo "OK! Gstreamer Good Plugin file exists at ${GOOD_PLUGIN_URL}"
 else
    echo "ERROR! Gstreamer Good Plugin file at URL: ${GOOD_PLUGIN_URL} is not found! Instalation will be aborted!"
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
# Lets start downloading in /tmp
# mkdir -p /tmp/recapture_dl_dir/plugin                        
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
rm -rf ~/Desktop/Recapture.desktop 2>/dev/null

sleep 3
# Create a Desktop icon
echo "Creating a Desktop Icon"
echo '[Desktop Entry]
Comment=
Exec=/bin/bash $HOME/.local/recapture/recapture-cli-wrapper.sh
GenericName=
Icon=media-record-symbolic
MimeType=
Name=Recapture
Path=
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application' > $HOME/Desktop/Recapture.desktop

sleep 3
# Remove downloaded files from /tmp
echo "Removing downloaded archives. we do not require them anymore."
rm -rf /tmp/recapture_dl_dir 


echo "You can now close the terminal window by using CTRL+C or ENTER"
# exec bash
read
sleep 10
