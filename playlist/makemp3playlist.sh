#!/bin/bash

oggfilelist=`ls -S ~/webuildlive/playlist/*.ogg`;

for name in $oggfilelist; do
   mp3name="${name/.ogg/.mp3}";
   #echo "mp3name is $mp3name";
   if [ ! -f $mp3name ]; then
	#echo "################### Converting - $name ####################";
   	ffmpeg -i "$name" -map_metadata 0:s:0 $mp3name; 
   else
	echo "$name is already convereted";
   fi
done;

echo "Updating Playlist";
ls ~/webuildlive/playlist/*.mp3 > ~/webuildlive/playlist/playlistmp3.txt
