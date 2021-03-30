#!/bin/bash

# set -o xtrace

DIR="$1"

if [[ -z "$DIR" ]]; then
   echo "Usage `basename $0` DIR"
   exit 1
fi

inotifywait --format '%e %w%f' -m -q -r "$DIR" | \
while read -r event fpath; do
   echo -e "\n$event - $fpath"
   if [[ $event != *'ISDIR'* ]]; then
      ls -laZ "$fpath"
   fi
done
