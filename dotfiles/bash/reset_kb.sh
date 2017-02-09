#!/usr/bin/env bash

sudo mkgo ~/.bash/usbreset.c $(lsusb|awk '$6 == "17ef:6047" { printf("/dev/bus/usb/%s/%.3s\n", $2, $4) }')
