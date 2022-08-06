#!/bin/bash

EXPOSURE_TIME=0
NUMBER_FRAMES=0
PAUSE_TIME=5

SCRIPT_PATH=$(dirname "$0")

# Function that prints usage and  help.
usage () {
  echo "Starts a timelapse on the camera attached on USB"
  echo "timelapse.sh --exposure-time EXPOSURE_TIME_IN_SECONDS --number-frames NUMBER_OF_FRAMES"
  echo "  -t | --exposure-time    - Hhe exposure time in seconds. For example for 1/4000 exposure, input here 0.00025"
  echo "  -f | --number-frames    - How many frames should be taken before ending the sequence"
  echo "  -p | --pause-time       - Optional, default is 5. How many seconds to wait before taking another frame after a frame is done."
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
  if [[ "$EXPOSURE_TIME" == "0" ]]; then
    echo "Invalid exposure time."
    echo " "
    usage
    exit 1;
  fi
  if (($NUMBER_FRAMES == 0)) || (($PAUSE_TIME == 0)); then
    echo "Please provide all mandatory arguments."
    echo " "
    usage
    exit 1;
  fi
  for i in $(seq 1 $NUMBER_FRAMES)
    do
      echo " "
      echo "${i} / ${NUMBER_FRAMES}"
      ${SCRIPT_PATH}/take-snapshot-bulb.sh ${EXPOSURE_TIME}
      sleep ${PAUSE_TIME}
    done
  echo "${NUMBER_FRAMES} frames done"
}

main
