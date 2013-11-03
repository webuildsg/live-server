#!/bin/bash


### Starting MP3 Stream.

# kill ices if it's running
sudo pkill -x ices0;

# refresh playlist
ls ~/webuildlive/playlist/*.mp3 > ~/webuildlive/playlist/playlistmp3.txt

# restart ices
echo "Starting Ices0 for MP3 Radio....."
sudo ices0 -c ~/webuildlive/config/ices.conf

sleep 5;

islive=`curl -su uid:lamepassword http://localhost:8000/admin/listmounts | grep "\/radio"`

#echo $islive;

if [ "$islive" = "" ]; then
  echo "Couldn't Start MP3 Radio";
else
  echo "Success!";
fi



# kill ices if it's running
sudo pkill -x ices;

# refresh playlist
ls ~/webuildlive/playlist/*.ogg > ~/webuildlive/playlist/playlist.txt

# restart ices
echo "Starting Ices2 for OGG Radio....."
sudo ices ~/webuildlive/config/icesplaylist.xml

islive=`curl -su uid:lamepasswords http://localhost:8000/admin/listmounts |
grep "\/radio-ogg"`

if [ -n "$islive" ]; then
  echo "Success!";
else
  echo "Couldn't Start OGG Radio";
fi
