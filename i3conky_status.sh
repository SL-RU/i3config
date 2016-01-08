#!/bin/bash

# Send the header so that i3bar knows we want to use JSON:
echo "{ \"version\": 1, \"stop_signal\": 10, \"cont_signal\": 12, \"click_events\": true }"

# Begin the endless array.
echo '['

# We send an empty first array of blocks to make the loop simpler:
echo '[],'

# Now send blocks with information forever:
conky -d -c $HOME/.i3/conky.conf


IFS="}"
while read;do
  IFS=" "
  STR=`echo $REPLY | sed -e s/[{}]//g -e "s/ \"/\"/g" | awk '{n=split($0,a,","); for (i=1; i<=n; i++) {m=split(a[i],b,":"); if (b[1] == "\"name\"") {NAME=b[2]} if (b[1] =="\"x\"") {X=b[2]} if (b[1] =="\"y\"") {Y=b[2]} } print NAME " " X " " Y}'`
  read NAME X Y <<< $STR
  X=$(($X-50))
#  case "${NAME}" in
#      \"yad\")
#	  notify-send "$(yandex-disk status)"
#	  ;;
#	  \"lol\")
#	  notify-send "LOL"
#      ;;
#    *)
#      ;;
#  esac
  IFS="}"
done
