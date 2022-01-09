#!/bin/bash

getInfo=$(cmus-remote -Q)
cmusStatus=$(echo "$getInfo" | grep "status" | cut -c 8-)
artist=$(echo "$getInfo" | grep "tag artist" | cut -c 12-)

if [ "$cmusStatus" == "playing" ] || [ "$cmusStatus" == "paused" ]; then
  if [[ $artist = *[!\ ]* ]]; then
    song=$(echo "$getInfo" | grep title | cut -c 11-)
    echo -n "$artist - $song"
  else
    filePath=$(echo "$getInfo" | grep file | cut -c 5- | sed 's/ /_/g')
    fileName=$(basename -s .mp3 $filePath | sed 's/_/ /g')
    echo -n "$fileName"
  fi
else
  echo -n "Stopped"
fi
