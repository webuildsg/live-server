#!/bin/bash

mp3filelist=`ls -S /home/chinmay/webuildlive/playlist/*.mp3`;

echo #mp3filelist

for name in $mp3filelist; do
   oggname="${name/.mp3/.ogg}";
   echo "oggname is $oggname";
   if [ ! -f $oggname ]; then
	#echo "################### Converting - $name ####################";
   	ffmpeg -i "$name" -map_metadata 0:s:0 -acodec libvorbis $oggname; 
   else
	echo "$name is already convereted";
   fi
done;

echo "Updating Playlist";
ls /home/chinmay/webuildlive/playlist/*.ogg > /home/chinmay/webuildlive/playlist/playlist.txt
