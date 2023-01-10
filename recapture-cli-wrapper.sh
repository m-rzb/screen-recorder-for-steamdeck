#!/bin/bash

# Usage: recapture (COMMAND) [OPTIONS...]
# 
# Where COMMAND is one of:
#   record
#         Start recording your screen, then save the recording when this program
#         exits.
#   replay - NOT WORKING
#         Start recording your screen, then save the most recent X seconds when
#         this program exits, where X is set by the '-length' option.
# 
# Available OPTIONS:
#   -audio-bitrate string
#         Audio stream bitrate (default "128")
#   -audio-device string
#         The PulseAudio source device to record audio from (default "echo-cancel-sink.monitor")
#   -length int
#         Length in seconds of replays (default 30)
#   -o string
#         Directory to save recordings to (default "$HOME/Videos/recapture")
#   -source string
#         The screen recording source, either "pipewire" or "x11" (default "pipewire")
#   -tmp string
#         Directory to save temporary recordings to (only for replay recording) (default "$HOME/Videos/recapture/.tmp")
#   -verbose
#         Print extra debugging info

# The line below is required only for Steam Deck
LD_PRELOAD=${LD_PRELOAD/_32/_64}

# Check if current session is using the Wayland Display Server or x11
# echo ${XDG_SESSION_TYPE} # this is not identifying the sessions correctly on Steam Deck
# Lets try with with loginctl instead..
LOGIN_SESSION_TYPE=$(loginctl show-session $(loginctl|grep $USER|awk '/'"seat0"'/{print $1}') -p Type | cut -d'=' -f2)

if [ "${LOGIN_SESSION_TYPE}" != "wayland" ]; then
    echo "This session does not use the Wayland Display Server."
    echo "For screen recording on '${LOGIN_SESSION_TYPE}' we should use 'x11' as source as well"
    RECORDING_SOURCE=x11
else 
    echo "This session uses the Wayland Display Server."
    echo "For screen recording on '${LOGIN_SESSION_TYPE}' we should use 'pipewire' as source"
    RECORDING_SOURCE=pipewire
fi

# Check default audio device
AUDIO_DEVICE=$(pactl get-default-sink)
echo "Currently detected default audio device is '$AUDIO_DEVICE'." 
echo "This device will be used to record the audio from."

cd $HOME/.local/recapture
echo $PWD

# GST_DEBUG=3 \
GST_VAAPI_ALL_DRIVERS=1 \
GST_PLUGIN_PATH=$HOME/.local/recapture/plugins \
LD_LIBRARY_PATH=$HOME/.local/recapture/lib \
./recapture record \
-source $RECORDING_SOURCE \
-audio-device "$AUDIO_DEVICE.monitor" \
& PIPED_PID=$!

while kill -s 0 $PIPED_PID; do sleep .1; done |

( zenity --progress --window-icon=/usr/share/icons/breeze/actions/16/media-record.svg --width 555 --height 35 --title="Recording in progress" --text="<big><big><b>Screen recording is in progress!</b></big>\n\nYour system currently uses <b>$LOGIN_SESSION_TYPE</b> as display sever\nIdentified audio device is <b>$AUDIO_DEVICE</b>\n\nThe video will be saved in <b>$HOME/Videos/recapture/</b>\n\n\nPress <b>Cancel</b> to stop recording.</big>" --pulsate --default-cancel  || kill -2 $PIPED_PID )
