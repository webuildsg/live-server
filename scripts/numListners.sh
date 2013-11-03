#!/bin/zsh

curl -su uid:lamepassword http://localhost:8000/admin/ | grep \>listeners -A 2 -m 1 | head -n 2 | tail -n 1 | cut -d">" -f 2 | cut -d"<" -f 1
