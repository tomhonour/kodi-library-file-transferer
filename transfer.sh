#!/bin/bash

echo "Is your destination folder in /home or /media? (Type either home or media):"

read dir

case $dir in

home)
	outdir=$(find /home -type d | fzf --prompt="Select destination folder: ")
	;;

media)
	outdir=$(find /media -type d | fzf --prompt="Select destination folder: ")
	;;

*)
	echo "You can only pick home or media. Exiting..."
	exit 1
	;;
esac

filename=$(find . -name "*.mp4" -o -name "*.mkv" | fzf -m)

echo "$filename" |\
while read line
do
	[[ "$line" ]] || break
	echo "In transfer: $line"
	temp=$(
	echo "$line" |\
	awk -F/ '{print $(NF)}' |\
	cut -d'.' -f1
	)
	mkdir -p "$outdir"/"$temp"
	cp -n "$line" "$outdir"/"$temp"
# cp -i fails for some reason.
done

echo "Complete."
