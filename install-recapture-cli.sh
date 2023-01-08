#!/bin/bash
#
#

# Check if the download URL exists.
DL_URL="https://git.sr.ht/~avery/recapture/refs/download/plugin-0.1.3/recapture-0.1.3.tar.gz"

if wget --spider ${DL_URL} 2>/dev/null; 
 then
    echo "OK! Recapture file exists at ${DL_URL}"
 else
    echo "ERROR! Online URL ${DL_URL} is not found!"
    exit 1
fi

# Remove previously created directory if exists.
echo "Removing existing instalation directory, if it was previously created."
sleep 1
rm -rf $HOME/.local/recapture &>/dev/null

# Create plugin instalation directory
echo "We need to create the instalation directory."
sleep 1
mkdir -p $HOME/.local/recapture

echo "Installing the plugin and scripts"
echo 1
# Download Recapture plugin.
mkdir -p /tmp/recapture_dl_dir/plugin                        
cd /tmp  

wget -O recapture_dl_dir/recapture-0.1.3.tar.gz \
		https://git.sr.ht/~avery/recapture/refs/download/plugin-0.1.3/recapture-0.1.3.tar.gz
tar -xvzf recapture_dl_dir/recapture-0.1.3.tar.gz -C recapture_dl_dir/plugin

# Move downloaded binary and libs to instalation directory
mv recapture_dl_dir/plugin/recapture/dist/deps/* $HOME/.local/recapture

# Make Recapture binary executable
chmod +x $HOME/.local/recapture/recapture

# Download Recapture CLI wrapper
wget -O recapture_dl_dir/recapture-cli-wrapper.sh \
        https://raw.githubusercontent.com/m-rzb/Screen-recorder-for-steamdeck/main/recapture-cli-wrapper.sh
        
# Move bash script to instalation directory
mv recapture_dl_dir/recapture-cli-wrapper.sh $HOME/.local/recapture/recapture-cli-wrapper.sh

# Make bash script executable
chmod +x $HOME/.local/recapture/recapture-cli-wrapper.sh

# Remove previously created Desktop icon
rm -rf ~/Desktop/Recapture.desktop 2>/dev/null

# Create a Desktop icon
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


# Remove downloaded files from /tmp
rm -rf /tmp/recapture_dl_dir 

