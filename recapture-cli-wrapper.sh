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


LD_PRELOAD=${LD_PRELOAD/_32/_64}

cd $HOME/.local/recapture
echo $PWD

HDMI_AUDIO_DEVICE="alsa_output.pci-0000_04_00.1.hdmi-stereo-extra2"
HEADPHONE_AUDIO_DEVICE="alsa_output.pci-0000_04_00.5-platform-acp5x_mach.0.HiFi__hw_acp5x_0__sink"
SPEAKER_AUDIO_DEVICE="alsa_output.pci-0000_04_00.5-platform-acp5x_mach.0.HiFi__hw_acp5x_1__sink"
ECHO_AUDIO_DEVICE="echo-cancel-sink"

# 1. HDMI 2. Headphone 3. Speaker 4. Echo(default)
if [[ $(pw-cli list-objects | grep $HDMI_AUDIO_DEVICE) ]]; then
    AUDIO_DEVICE=$HDMI_AUDIO_DEVICE
elif [[ $(pw-cli list-objects | grep $HEADPHONE_AUDIO_DEVICE) ]]; then
    AUDIO_DEVICE=$HEADPHONE_AUDIO_DEVICE
elif [[ $(pw-cli list-objects | grep $SPEAKER_AUDIO_DEVICE) ]]; then
    AUDIO_DEVICE=$SPEAKER_AUDIO_DEVICE
else
    AUDIO_DEVICE=$ECHO_AUDIO_DEVICE
fi

GST_VAAPI_ALL_DRIVERS=1 \
GST_PLUGIN_PATH=$HOME/.local/recapture/plugins \
LD_LIBRARY_PATH=$HOME/.local/recapture/lib \
./recapture record \
-audio-device "$AUDIO_DEVICE.monitor" \
& PIPED_PID=$!

while kill -s 0 $PIPED_PID; do sleep .1; done |

( zenity --progress --window-icon=/usr/share/icons/breeze/actions/16/media-record.svg --width 500 --height 35 --title="Recording in progress" --text='<span font="14" >Screen recording is in progress!\n\nPress <b>Cancel</b> to stop recording.</span>' --pulsate --default-cancel  || kill -2 $PIPED_PID )
