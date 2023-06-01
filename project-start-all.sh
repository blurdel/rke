#!/bin/bash

sudo systemctl start docker
echo "docker started"

cd ~/rke/scripts && docker-compose up -d
echo "docker-compose up"

gnome-terminal -- sh -c 'cd ~/gitrepos/project/ && ./launch.sh'

/usr/bin/google-chrome --incognito --new-window http://localhost:8080 & disown

sleep 5
