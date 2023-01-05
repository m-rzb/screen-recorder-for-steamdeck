# Screen-recorder-for-steamdeck
Screen recorder for Steam deck in Game Mode, using a basic, quick and dirty bash script and the Recapture Plugin from Crankshaft project.

Big thanks to the Crankshaft project!

You would require to install the Crankshaft flatpak first and then the recapture plugin from Crankshaft Settings.

See installation instructions at https://crankshaft.space/


## Installing on your Steam Deck

You need to be in Desktop Mode.
Download "Install Recapture CLI Wrapper.desktop" using this link [this link](https://raw.githubusercontent.com/m-rzb/Screen-recorder-for-steamdeck/testing/Install%20Recapture%20CLI%20Wrapper.desktop) on your Steam Deck. Right click the link and save the file somewere you can find. No need to make the file executable.

Double clicking the downloaded file will download the Recapture plugin and install a script as well as create a Desktop Icon. 

You can add the Recapture.desktop file as Non-Steam Game.

------------

On Steam Deck the Recapture plugin should be installed here:
/home/deck/.var/app/space.crankshaft.Crankshaft/data/crankshaft/plugins/recapture/

I would advise you to save a copy of the plugin. It includes the binary of recapture and all required libs. 

Next, download the bash script "recapture-crankshaft_plugin.sh" and probably make it executable.

Recapture.desktop is optional. If you decide to use it, make sure you adjust this part: 
Exec=/bin/bash /home/deck/Desktop/recapture-crankshaft_plugin.sh

Now that we have the plugin and the bash script, we should add the bash script (or the desktop file) as Non-Steam Game.
Back in Game Mode, you should see Recapture or the bash script "recapture-crankshaft_plugin.sh" as an app. To make life easier, go to Recapture's Controller Settings and select "Web Browser" as Current Layout. Now you should be able to press on Cancel by using A button or use the mouse on Steam Deck.

Note, the recording is working only in Game Mode. You can start and stop the script in Desktop Mode, however, there would be no usable video. Recordings are saved in /home/deck/Videos/recapture/ as mp4. 


There has been no extensive testing, and the script and the recapture plugin has been working at the time of writing of this script. The script is provided as is, and I make no promises or guarantees. I would not be responsible for any damages caused to your Steam Deck, house, pet etc. Use it at your own risk!
There might be mistakes or more elegant ways of achieving that, however, I do not write code for a living and my free time is limited.


References and thanks to:

https://git.sr.ht/~avery/recapture

https://crankshaft.space/

https://github.com/Plagman/gamescope/issues/561

https://stackoverflow.com/questions/15266329/in-a-bash-script-that-uses-zenity-progress-progress-bar-reading-from-a-pipe-h

https://steamcommunity.com/app/1675200/discussions/0/3387291961143576207/


There are probably more that I have missed to mention.
