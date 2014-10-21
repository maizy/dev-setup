#!/bin/bash

BASE='/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources'
SOUND='volume.aiff'
OLD_SOUND_URL='https://dl.dropboxusercontent.com/u/2243004/volume.aiff'

# --
NOW=`date +'%Y%m%d%H%M%S'`
sudo cp "${BASE}/${SOUND}" "${BASE}/${SOUND}.bkp.${NOW}"
curl -o '/tmp/maverics_volume.aiff' "${OLD_SOUND_URL}" 2>/dev/null
sudo mv -f '/tmp/maverics_volume.aiff' "${BASE}/${SOUND}"

echo -e "\n\nDone\nDon't forget to turn on 'Play feedback when volume is changed'"
echo -e " in System Preference -> Sound"
