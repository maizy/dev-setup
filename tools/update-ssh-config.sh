#!/bin/bash

# combine files in ~/.ssh/config.d into ~/.ssh/config
# based on https://github.com/jokeyrhyme/dotfiles/blob/master/scripts/ssh-config-d.sh

CONF="$HOME"'/.ssh/config'
CONFD="$HOME"'/.ssh/config.d'
NOW=`date -u +%Y-%m-%d-%H-%M-%S`

if [ ! -d "$HOME"'/.ssh' ]; then
  # nothing to do, exit early
  echo "no ~/.ssh"
  exit 1;
fi

if [ ! -d "$CONFD" ]; then
  # nothing to do, exit early
  echo "no ~/.ssh/config.d"
  exit 1;
fi

if [ -f "$CONF" ]; then
  echo "backup existing ~/.ssh/config"
  mkdir -p "$HOME"'/.ssh/bkp'
  mv "$CONF" "$HOME"'/.ssh/bkp/config.'$NOW'.bkp'
fi

touch "$CONF"
echo -e "# Builded on $NOW\n" >> "$CONF"
for f in `ls "$CONFD"` ; do
  echo "$CONFD/$f"
  echo -e "\n# from $CONFD/$f\n" >> "$CONF"
  cat "$CONFD/$f" >> "$CONF"
done
echo -e '\n\n' >> "$CONF"
