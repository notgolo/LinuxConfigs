#!/bin/bash

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

placeholder="/home/golo/.config/conky/mpdImages/placeholder.png"
cover_image="/home/golo/.config/conky/mpdImages/conky_cover.jpg"
last_album_file="/tmp/last_album.txt"

MPD_HOST="127.0.0.1"
MPD_PORT="6602"
MPD_PASSWORD="kainebestgirl"

# Query MPD for current song info via netcat
mpd_query=$(
  (echo "password $MPD_PASSWORD"; echo "currentsong"; echo "close") | nc $MPD_HOST $MPD_PORT
)

# Parse artist, album, file from response
artist=$(echo "$mpd_query" | grep -m1 "^Artist:" | cut -d ' ' -f2-)
album=$(echo "$mpd_query" | grep -m1 "^Album:" | cut -d ' ' -f2-)
file=$(echo "$mpd_query" | grep -m1 "^file:" | cut -d ' ' -f2-)

if [[ -f "$last_album_file" ]]; then
  last_album=$(cat "$last_album_file")
else
  last_album=""
fi

if [[ -z "$album" ]]; then
  cp "$placeholder" "$cover_image"
  # Reset last_album so next time album changes update cover
  rm -f "$last_album_file"
  exit 0
fi

# Determine album directory path depending on whether file path is absolute
if [[ "$file" = /* ]]; then
  album_dir=$(dirname "$file")
else
  music_root="/mnt/5992968e-dedf-4a38-95e0-8ca996ead300/Media/Music/"
  album_dir="$music_root/$(dirname "$file")"
fi

# Normalize path
album_dir=$(realpath "$album_dir")

if [[ "$album" != "$last_album" ]]; then
  echo "$album" > "$last_album_file"
  
  cover=$( /usr/bin/find "$album_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | head -n 1 )
  
  if [[ -z "$cover" ]]; then
    cp "$placeholder" "$cover_image"
  else
    convert "$cover" -resize "250x225>" -alpha off "$cover_image"
  fi

  sync

fi
