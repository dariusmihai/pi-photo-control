#!/bin/sh

EXPOSURE_TIME=$1

# trigger the camera
gphoto2 --auto-detect --trigger-capture --wait-event=${EXPOSURE_TIME}s
