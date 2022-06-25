#!/bin/bash

spinner=( '|' '/' '-' '\' )
spin(){
	while [ 1 ]
	do
		for i in "${spinner[@]}"
		do
			echo -ne "\r$i"
			sleep 0.2
		done
	done
}

filename=$(find . -name "*.mp4" -o -name "*.mkv" | fzf -m --prompt="Select the files you want to rename (Press Esc to skip): ")

echo "$filename" > oldnames.txt
echo "$filename" |\
while read line
do
	[[ "$line" ]] || break
	path=$(
	echo "$line" |\
# taken from stackexchange
	awk 'BEGIN{FS=OFS="/"}{NF--; print}'
	)
	filename=$(
	echo "$line" |\
	awk -F/ '{print $(NF)}' |\
# taken from stackexchange
	sed 's/\(.*\)\..*/\1/'
	)
	filetype=$(
	echo "$line" |\
	awk -F. '{print $(NF)}'
	)
	echo -n "Enter a new filename for "
	echo -n "$filename"
	echo " (Press Enter to skip):"
	read -e newname < /dev/tty
	case $newname in
	"")
	;;
	*)
	mv "$line" "$path"/"$newname"."$filetype"
	;;
	esac
done

echo "Is your destination folder in /home or /media? (Type either home or media):"
read -e dir

case "$dir" in
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
spin &
pid=$!
	temp=$(
	echo "$line" |\
	awk -F/ '{print $(NF)}' |\
# taken from stackexchange
	sed 's/\(.*\)\..*/\1/'
	)
	mkdir -p "$outdir"/"$temp"
	cp -i "$line" "$outdir"/"$temp" < /dev/tty
kill "$pid"
echo ""
done

echo "Complete."
