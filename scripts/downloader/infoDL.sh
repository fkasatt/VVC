#!/bin/bash

dir="$HOME/Research"
cd $dir/list
cols=$(cat "${dir}/list/VVC.list" | wc -l)
cnt=1

cat "${dir}/list/VVC.list" | while read id
do
	yt-dlp "https://youtu.be/${id}" --skip-download --write-info-json -o "${dir}/info_json/%(id)s.%(ext)s"
	echo -en "${id}," >> "${dir}/list/channel.list"
	cat "${dir}/info_json/${id}.info.json" | jq '.channel' | cat >> "${dir}/list/channel.list"

	echo "${cnt}/${cols}"
	cnt=$((cnt+1))
done
