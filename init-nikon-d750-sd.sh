#!/bin/sh

# gphoto2 --auto-detect --get-config capturetarget

echo "Configuring for Nikon D750 with Memory Card capture target"
echo " "

gphoto2 --set-config bulb=1 --wait-event=5 --set-config capturetarget=1
