#!/bin/sh
# Needed because hildon sends DesktopOrientationChanged before it actually
# rotates the display

sleep 1

export DISPLAY=:0

tsids=$(xinput --list | awk -v search="Touch|fts_ts" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

ctrc=$(xrandr | awk '/ connected/{print $1}' | awk 'NR==1 {print; exit}')

for i in $tsids
do
        xinput map-to-output $i $ctrc
done
