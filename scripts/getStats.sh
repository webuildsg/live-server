#!/bin/bash

now=$(date +"%Y%m%d_%H%M")
suffix="_stats.xml"
statsfile="~/webuildlive/stats/$now$suffix"

curl -su uid:lamepassword http://localhost:8000/admin/stats > $statsfile
