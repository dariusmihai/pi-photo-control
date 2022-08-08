#!/bin/sh

SHUTTER_SPEED_ID=$1

# trigger the camera
gphoto2 --auto-detect --set-config shutterspeed=${SHUTTER_SPEED_ID} --trigger-capture
