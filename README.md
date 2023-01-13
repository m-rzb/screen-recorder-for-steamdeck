# Simple Screen Recorder for Steam Deck
Screen recorder for Steam deck, using a basic, quick and dirty script around [Avery's Recapture binary and libs](https://git.sr.ht/~avery/recapture).

Big thanks to the Crankshaft project!


**Note:** The script will download the Recapture binary and the libraries from Avery's Recapture archive. In addition, for screen recording to work in Desktop Mode the libgstximagesrc.so will be downloaded from the steamos extra repo. I do not maintain those repos and libraries! If the URLs to those repos change or the archives are removed, the script will not function.

## Why?

I had a week off work and wanted to record a game play on my Steam Deck in Game Mode. I looked for various options, but they were either too complicated to achieve what I wanted or just did not work in Game Mode. Installing Recapture binary and libraries locally, with the help of this bash script, does not require turning off the read-only filesystem on the Steam Deck, installing additional packages with `pacman` or distrobox etc. The function of this CLI wrapper is simple, and has only an option to start and stop recording. I hope it will be useful for others as well.


## Installing on your Steam Deck

You need to be in Desktop Mode.
Download `Install_Recapture_CLI_Wrapper.desktop` using [this link](https://raw.githubusercontent.com/m-rzb/Screen-recorder-for-steamdeck/main/Install_Recapture_CLI_Wrapper.desktop) on your Steam Deck. Right click the link and save the file somewhere you can find it later.

No need to make the downloaded file executable. Double-clicking the file will download the Recapture binary and the required libraries, install a script and create a Desktop Icon. 

You should add now the `Recapture.desktop` file as Non-Steam Game. Recapture, with the help of this CLI wrapper, records the screen in Game Mode as well as Desktop Mode.

You can delete the `Install_Recapture_CLI_Wrapper.desktop` file now. 

Back in Game Mode, you should be able to find Recapture app/shortcut. 

The function is very basic. You can only Start and Cancel the screen recording. All videos are saved as mp4 in `~/Videos/recapture directory`.

Note: To make selecting Cancel button easier, go to Recapture's Controller Settings and select "Web Browser" as Current Layout. Now you should be able to press on Cancel by using A button or use the mouse on Steam Deck. You can also Cancel recording by selecting Home, from the left Steam menu, selecting Recapture app and closing the app from there.


------------
 
## Warning!

There has been no extensive testing! The script and the Recapture plugin has been working for me at the time of writing of this script. The script is provided as is. I make no promises and give no guarantees. I would not be responsible for any damages caused to your Steam Deck, house, pet etc. Use it at your own risk!

There might be mistakes in the scripts or more elegant ways of achieving those tasks, however, I do not write code for a living and my free time is limited.


## References and thanks to:

https://git.sr.ht/~avery/recapture

https://crankshaft.space/

https://github.com/Plagman/gamescope/issues/561

https://stackoverflow.com/questions/15266329/in-a-bash-script-that-uses-zenity-progress-progress-bar-reading-from-a-pipe-h

https://steamcommunity.com/app/1675200/discussions/0/3387291961143576207/


There are probably more sources that I have used as reference and missed to mention.
