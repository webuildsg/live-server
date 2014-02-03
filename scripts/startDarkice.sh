#!/bin/bash

NULLRUNNING=`pactl list | grep "Argument: sink_name=stream" | wc -l`

if [[ $NULLRUNNING -lt 1 ]]; then
  #echo "loading null"	
  pactl load-module module-null-sink sink_name=stream sink_properties=device.description="Streaming Output";
fi

echo "starting darkicey....."

/usr/bin/darkice
