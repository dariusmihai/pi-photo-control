#!/bin/sh

# gphoto2 --auto-detect --get-config capturetarget

echo "Configuring for Nikon D750 with Memory Card capture target"
echo " "

gphoto2 --auto-detect --set-config capturetarget=1

