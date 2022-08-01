#!/bin/sh

echo "Listing possible capture targets"
echo " "

gphoto2 --auto-detect --get-config capturetarget

echo " "
echo "Please input the id corresponding to the capture target of where you want the photos to be saved"

read CAPTURE_TARGET

gphoto2 --set-config bulb=1 --wait-event=5 --set-config capturetarget=$CAPTURE_TARGET
