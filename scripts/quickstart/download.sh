#!/bin/bash

FILE_NUMBER=$1

usage() {
  echo "Usage: ./download.sh FILE_NUMBER"
  echo " "
  echo "Downloads a file from the camera"
  echo "FILE_NUMBER is the file number as shown by ./list.sh"
}

if [[ $# -eq 0 ]];
then
    echo " "
    echo "No arguments provided"
    usage
    exit 1
fi

gphoto2 --auto-detect --get-file ${FILE_NUMBER}