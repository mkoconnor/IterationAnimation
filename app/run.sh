#!/bin/bash
set -e -x

rm -rf /tmp/foo*svg
rm /tmp/out.mp4
stack build
stack exec IterationAnimation-exe
parallel 'inkscape {} --export-dpi=270 --export-png {.}.png' ::: /tmp/foo*svg
ffmpeg -i /tmp/foo%03d.png -r 30 -pix_fmt yuv420p /tmp/out.mp4
