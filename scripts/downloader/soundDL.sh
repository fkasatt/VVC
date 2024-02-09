#!/bin/bash
dir="$(git rev-parse --show-toplevel)"

mkdir -p "${dir}/sound"
mkdir -p "${dir}/sound/VVC"
mkdir -p "${dir}/sound/VVC/original"

cols=$(cat "${dir}/list/soundDL${1}.list" | wc -l)
cnt=1

cat "${dir}/list/soundDL${1}.list" | while read id
do
	num=$(yt-dlp -F "https://youtu.be/${id}" | rg 'audio only' | rg 'm4a' | tail -1 | awk '{print $1}')
	yt-dlp -f $num "https://youtu.be/${id}" -o "${dir}/sound/VVC/original/${id}.m4a"

	echo "${id}\t${cnt}/${cols}"
	cnt=$((cnt+1))
done
