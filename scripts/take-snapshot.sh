#!/bin/sh

EXPOSURE_TIME=$1

# trigger the camera
gphoto2 --auto-detect --set-config shutterspeed=${EXPOSURE_TIME}s --capture-image
