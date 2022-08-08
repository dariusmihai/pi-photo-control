#!/bin/sh

EXPOSURE_TIME=$1

# trigger the camera
gphoto2 --auto-detect --set-config shutterspeed=52 --set-config bulb=1 --capture-image --wait-event=${EXPOSURE_TIME}s
