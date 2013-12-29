#!/bin/bash

CFGS_DIR="$HOME"'/.rootcfgs'
mkdir -p "$CFGS_DIR"
cd "$CFGS_DIR"
find "$HOME" -iname '.*' -depth 1 -exec ln -sf {} ./ \;
