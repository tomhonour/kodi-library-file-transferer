#!/bin/bash

# This script works perfectly except that it will produce exactly 1 cp error because of the loop. The problem is that $temp is assigned in the loop but is also the condition.

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

dirname=$(
echo "$filename" |\
awk -F/ '{print $(NF)}' |\
cut -d'.' -f1
)

temp="a"
count="1"
while [ "$temp" != '' ]
do
	temp=$(echo "$dirname" |\
	awk -v awkcount="$count" 'NR==awkcount')
	mkdir -p "$outdir"/"$temp"

	temp1=$(echo "$filename" |\
	awk -v awkcount="$count" 'NR==awkcount')
	echo "In transfer: $temp1"
	cp -i "$temp1" "$outdir"/"$temp"
	((count++))
done

echo "Complete."
