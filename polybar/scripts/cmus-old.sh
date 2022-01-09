#!/bin/bash

accentColor=#7fbbb3

getInfo=$(cmus-remote -Q)
cmusStatus=$(echo "$getInfo" | grep "status" | cut -c 8-)
artist=$(echo "$getInfo" | grep "tag artist" | cut -c 12-)

case $cmusStatus in
  playing) icon="" ;;
  paused) icon="" ;;
  stopped) icon="栗" ;;
  *) icon="" ;;
esac

if [ "$cmusStatus" != "stopped" ]; then
  if [[ $artist = *[!\ ]* ]]; then
    song=$(echo "$getInfo" | grep title | cut -c 11-)
    echo -n "%{F$accentColor}$icon%{F-} $artist - $song"
  else
    filePath=$(echo "$getInfo" | grep file | cut -c 5- | sed 's/ /_/g')
    fileName=$(basename -s .mp3 $filePath | sed 's/_/ /g')
    echo -n "%{F$accentColor}$icon%{F-} $fileName"
  fi
else
  echo -n "%{F$accentColor}$icon%{F-} Nothing playing"
fi
