#!/bin/bash

EXPOSURE_TIME=0
NUMBER_FRAMES=0
PAUSE_TIME=5
SHUTTER_SPEED=-1

SCRIPT_PATH=$(dirname "$0")

# Function that prints usage and  help.
usage () {
  echo "Starts a timelapse on the camera attached on USB"
  echo " "
  echo "timelapse.sh --exposure-time EXPOSURE_TIME_IN_SECONDS --number-frames NUMBER_OF_FRAMES"
  echo "  -t | --exposure-time    - The exposure time in seconds. "
  echo "			    For example for 50 seconds exposure, input here 50."
  echo "			    For a half second exposure, input 0.5"
  echo "			    For exposures shorter than 0.5 seconds, please use --shutter-speed."
  echo "		            ! Cannot be used together with --shutter-speed"
  echo " "
  echo "  -s | --shutter-speed    - The ID of the desired shutterspeed in the output of "
  echo "		            gphoto2 --getconfig shutterspeed."
  echo "			    ! Cannot be used together with --exposure-time."
  echo " "
  echo "  -f | --number-frames    - How many frames should be taken before ending the sequence"
  echo " "
  echo "  -p | --pause-time       - Optional, default is 5. How many seconds to wait "
  echo "			    before taking another frame after a frame is done."
  echo " "
  echo "  -h | --help             - Display this help"

  echo " "
  echo "./timelapse.sh --exposure-time 5 --number-frames 20 --pause-time 10"
  echo "The above command will start a sequence of 20 frames of 5 seconds exposure time each,"
  echo "  waiting 10 seconds before starting a new frame after one is done."
  echo " "
  echo "This means that photos will be 15 seconds apart from each other, because:"
  echo " - first frame takes 5 seconds of exposure time"
  echo " - after it is done, waiting 10 seconds before starting the next one"
  echo " - starting second frame, 15 seconds after the first frame has started (10 seconds after it is finished)"
}

# Print usage if no arguments are provided to the script
if [[ $# -eq 0 ]]
then
    echo " "
    echo "No arguments provided"
    usage
    exit 1
fi

while [[ $# -gt 0 ]];
do
    case $1 in
        -t|--exposure-time)
            EXPOSURE_TIME=$2
            shift 2
            ;;
        -f|--number-frames)
            NUMBER_FRAMES=$2
            shift 2
            ;;
        -p|--pause-time)
            PAUSE_TIME=$2
            shift 2
            ;;
	-s|--shutter-speed)
	    SHUTTER_SPEED=$2
	    shift 2
            ;;
        -*|--*)
            echo " "
            echo "Unknown option $1"
            usage
            exit 1
            ;;
        *)
            echo " "
            echo "Invalid argument $1"
            usage
            exit 1
            ;;
    esac
done

main() {
  echo "exposure-time: ${EXPOSURE_TIME}"
  echo "shutter-speed: ${SHUTTER_SPEED}"
  if [[ "$EXPOSURE_TIME" == "0" ]] && [[ "$SHUTTER_SPEED" == "-1" ]]; then
	echo " "
    echo "Please specify either --exposure-time or --shutter-speed"
    echo " "
    usage
    exit 1;
  elif [[ "$EXPOSURE_TIME" != "0" ]] && [[ "$SHUTTER_SPEED" != "-1" ]]; then
    echo " "
    echo "--exposure-time and --shutter-speed cannot be used at the same time."
    echo " "
    usage
    exit 1
  fi

  if (($NUMBER_FRAMES == 0)) || (($PAUSE_TIME == 0)); then
	echo " "
    echo "Please provide all mandatory arguments."
    echo " "
    usage
    exit 1;
  fi

  SNAPSHOT_SCRIPT="take-snapshot-bulb.sh";

  if [ $(echo "$SHUTTER_SPEED >= 0" | bc -l) -eq 1 ]; then
    SNAPSHOT_SCRIPT="take-snapshot.sh"
    echo "Using regular snapshot mode (shutter-speed)"
    echo " "
  else
    if [ $(echo "$EXPOSURE_TIME < 0.5" | bc -l) -eq 1 ]; then
   	  echo " "
      echo "You have specified --exposure-time ${EXPOSURE_TIME}"
      echo "For exposures shorter than 0.5 seconds please use --shutter-speed"
      echo " "
      usage
      exit 1
    fi

    echo "Using bulb snapshot mode (exposure-time)"
    echo " "
  fi

  

  for i in $(seq 1 $NUMBER_FRAMES)
    do
      echo " "
      echo "${i} / ${NUMBER_FRAMES}"
      ${SCRIPT_PATH}/${SNAPSHOT_SCRIPT} ${EXPOSURE_TIME}
      sleep ${PAUSE_TIME}
    done
  echo "${NUMBER_FRAMES} frames done"
}

main
