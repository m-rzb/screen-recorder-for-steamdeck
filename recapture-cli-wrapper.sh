#!/bin/bash

# Replaced Recapture with gst-launch-1.0 which should be preinstalled on steam deck
# The line below is required only for Steam Deck
LD_PRELOAD=${LD_PRELOAD/_32/_64}

cd $HOME/.local/recapture
echo $PWD

# Check if current session is using the Wayland Display Server or x11
# echo ${XDG_SESSION_TYPE} # this is not identifying the sessions correctly on Steam Deck
# Lets try with with loginctl instead..
LOGIN_SESSION_TYPE=$(loginctl show-session $(loginctl|grep $USER|awk '/'"seat0"'/{print $1}') -p Type | cut -d'=' -f2)

echo $LOGIN_SESSION_TYPE
if [ "${LOGIN_SESSION_TYPE}" != "wayland" ]; then
    DISPLAY_SERVER="X11 Display Server"
    echo "For screen recording on '${DISPLAY_SERVER}' we should use 'x11' plugin"
    RECORDING_SOURCE="ximagesrc display-name=:0 show-pointer=true use-damage=false "
else
    DISPLAY_SERVER="Wayland Display Server"
    echo "For screen recording on '${DISPLAY_SERVER}' we should use 'pipewire' plugin"
    RECORDING_SOURCE="pipewiresrc do-timestamp=True "
fi

# lets set some more variables
#RECORDING_SOURCE_PIPEWIRE="pipewiresrc do-timestamp=True "
#RECORDING_SOURCE_X11="ximagesrc display-name=:0 show-pointer=true use-damage=false "
VIDEO_VAR="! queue ! vaapipostproc ! queue ! vaapih264enc ! h264parse ! mux. "
AUDIO_VAR="! queue ! audioconvert ! audio/x-raw,rate=44100,channels=2 ! lamemp3enc target=bitrate bitrate=128 cbr=true ! mux. "
DATE_VAR=$(date "+%Y-%m-%d %H:%M")

# Check default audio device
AUDIO_DEVICE=$(pactl get-default-sink)
echo "Currently detected default audio device is '$AUDIO_DEVICE'."
echo "This device will be used to record the audio from."

GST_VAAPI_ALL_DRIVERS=1 \
GST_PLUGIN_PATH=$HOME/.local/recapture/plugins \
LD_LIBRARY_PATH=$HOME/.local/recapture/libs \
    gst-launch-1.0 -e \
                $RECORDING_SOURCE \
                $VIDEO_VAR \
        pulsesrc device="$AUDIO_DEVICE.monitor" \
                $AUDIO_VAR \
         mp4mux  name=mux ! filesink location=/home/deck/Videos/"$DATE_VAR".mp4 \
            & PIPED_PID=$!

while kill -s 0 $PIPED_PID; do sleep .1; done |


( zenity --progress --window-icon=/usr/share/icons/breeze/actions/16/media-record.svg --width 555 --height 35 --title="Recording in progress" --text="<big><b>Screen recording is in progress!</b></big>\n\nYour system currently uses <b>$DISPLAY_SERVER</b>.\nIdentified audio device is <b>$AUDIO_DEVICE</b>\n\nThe video will be saved in <b>$HOME/Videos/recapture/</b>\n\n\nPress <b>Cancel</b> to stop recording." --pulsate --default-cancel  || kill -2 $PIPED_PID )
