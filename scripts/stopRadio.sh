#!/bin/bash

# kill ices
sudo pkill -x ices;

sleep 1;

islive=`curl -su uid:lamepassword http://localhost:8000/admin/listmounts | 
grep "\/radio-ogg"`

if [ -z "$islive" ]; then
  echo "Stopped";
else
  echo "Ooops still running";
fi



# kill ices0
sudo pkill -x ices0;

sleep 1;

islive=`curl -su uid:lamepassword http://localhost:8000/admin/listmounts | 
grep "\/radio"`

if [ -z "$islive" ]; then
  echo "Stopped";
else
  echo "Ooops still running";
fi
