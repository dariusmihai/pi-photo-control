# pi-timelapse-control
Scripts for controlling a DSLR Camera using a Raspberry pi or other linux machines

# How to use the scripts.
1. Run init-camera.sh.
  - It will show a list of possible locations where to save the photos, depending on your camera.
  - It will then ask you to choose where to save the photos. 
  - Type the number corresponding to the one that you want (usually Memory Card) and then hit Enter
2. Run timelapse.sh --help to see a list of possible options.
3. Run timelapse.sh with the options that you want.

For example:
`./timelapse.sh --exposure-time 5 --number-frames 20 --pause-time 10`
This will start a sequence of 20 photos, each having a 5 seconds exposure time, with a pause of 10 seconds between exposures.
