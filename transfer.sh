#!/bin/bash

filename=$(find . -name "*.mp4" -o -name "*.mkv" | fzf -m --prompt="Select the files you want to rename: ")

echo "$filename" > oldnames.txt
echo "$filename" |\
while read line
do
	[[ "$line" ]] || break
	path=$(
	echo "$line" |\
	awk 'BEGIN{FS=OFS="/"}{NF--; print}'
	)
	filename=$(
	echo "$line" |\
	awk -F/ '{print $(NF)}' |\
	cut -d'.' -f1
	)
	filetype=$(
	echo "$line" |\
	awk -F. '{print $(NF)}'
	)
	echo -n "Enter a new filename for: "
	echo "$filename"
	read newname </dev/tty
	mv "$line" "$path"/"$newname"."$filetype"
done

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

filename0=$(find . -name "*.mp4" -o -name "*.mkv" | fzf -m --prompt="Select the files you want to move: ")

echo "$filename0" |\
while read line
do
	[[ "$line" ]] || break
	echo "Moving file: $line"
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
