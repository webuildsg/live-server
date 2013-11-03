#!/bin/bash

sudo systemctl status murmur.service icecast.service;
ps -AL | grep -e mumble -e darkice;
