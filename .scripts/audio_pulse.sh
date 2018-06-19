#!/bin/bash

# This is the ffmpeg command that the audio shortcut in i3 will run.

# Pick a file name for the output file based on availability:

while [[ -f $HOME/audio$n.flac ]]
do
	n=$((n+1))
done
filename="$HOME/audio$n.flac"

# The actual ffmpeg command:

ffmpeg \
 -f alsa -ii default \
 -c:a flac \
 $filename
