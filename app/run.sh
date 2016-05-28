#!/bin/bash
set -e -x

rm -rf /tmp/foo*svg
stack build
stack exec IterationAnimation-exe
parallel 'inkscape {} --export-png {.}.png' ::: /tmp/foo*svg
ffmpeg -i /tmp/foo%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p /tmp/out.mp4
