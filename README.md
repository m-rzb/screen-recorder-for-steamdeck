# Screen-recorder-for-steamdeck
Screen recorder for Steam deck in Game Mode, using a basic, quick and dirty bash script and the Recapture Plugin from Crankshaft project.

Big thanks to the Crankshaft project!


## Why?

I had a week off work and wanted to record a game play on my Steam Deck in Game Mode. I looked for various options, but they were either too complicated to achieve what I wanted or just did not work in Game Mode. Installing Recapture plugin with the bash script locally does not require turning off the read-only filesystem on the Steam Deck, installing additional packages or distrobox etc. It is very primitive and has only an option to start and stop recording, however, I hope it will be useful for other as well.


## Installing on your Steam Deck

You need to be in Desktop Mode.
Download "Install_Recapture_CLI_Wrapper.desktop" using this link [this link](https://raw.githubusercontent.com/m-rzb/Screen-recorder-for-steamdeck/testing/Install%20Recapture%20CLI%20Wrapper.desktop) on your Steam Deck. Right click the link and save the file somewhere you can find it. 

No need to make the file executable. Double clicking the downloaded file will download the Recapture plugin, install a script and create a Desktop Icon. 

You should add now the Recapture.desktop file as Non-Steam Game. Recapture records the screen only in Game Mode!

Note: Executing Recapture.desktop in Desktop Mode will not record the screen. Recording will fail, even though you will find a new video file in ~/Videos/recapture.

Back in Game Mode, you should be able to find Recapture app/shortcut. 

The function is very basic. You can only Start and Cancel the screen recording. All videos are saved as mp4 in ~/Videos/recapture directory.

Note: To make selecting Cancel button easier, go to Recapture's Controller Settings and select "Web Browser" as Current Layout. Now you should be able to press on Cancel by using A button or use the mouse on Steam Deck. You can also Cancel recording by selecting Home, from the left Steam menu, selecting Recapture app and closing the app from there.


------------
 
## Warning !

There has been no extensive testing, and the script and the recapture plugin has been working at the time of writing of this script. The script is provided as is. I make no promises and give no guarantees. I would not be responsible for any damages caused to your Steam Deck, house, pet etc. Use it at your own risk!
There might be mistakes in the scripts or more elegant ways of achieving that, however, I do not write code for a living and my free time is limited.


## References and thanks to:

https://git.sr.ht/~avery/recapture

https://crankshaft.space/

https://github.com/Plagman/gamescope/issues/561

https://stackoverflow.com/questions/15266329/in-a-bash-script-that-uses-zenity-progress-progress-bar-reading-from-a-pipe-h

https://steamcommunity.com/app/1675200/discussions/0/3387291961143576207/


There are probably more that I have missed to mention.
