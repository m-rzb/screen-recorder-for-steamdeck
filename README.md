# Screen-recorder-for-steamdeck
Screen recorder for steam deck, using  basic quick and dirty bash script and the recapture plugin from Crankshaft

You would require to install the Crankshaft flatpak first and then the recapture plugin from Crankshaft Settings.

See installation instructions at https://crankshaft.space/


On Steam Decck the Recapture plugin should be installed here:
/home/deck/.var/app/space.crankshaft.Crankshaft/data/crankshaft/plugins/recapture/

I would advise you to save a copy of the plugin. It includes the binary of recapture and all required libs. 

Next, download the bash scrpt "recapture-crankshaft_plugin.sh" and probably make it executable.

Recapture.desktop is optional. If you decide to use it, make sure you adjust this part: 
Exec=/bin/bash /home/deck/Desktop/recapture-crankshaft_plugin.sh

Now that we have the plugin and the bash script, we should add the bash script (or the desktop file) as Non-Steam Game.

Note, the recording is working only in Game Mode. You can start and stop the script in Desktop Mode, however, there would be no usable video. Recordings are saved in /home/deck/Videos/recapture/ as mp4. 


There has been no extensive testing, and the script and the recapture plugin has been working at the time of writting of this script. The script is provided as is, and I make no promises or guarantees. I would not be responsible for any damages caused to your Steam Deck, house, pet etc. Use it at your own risk!

