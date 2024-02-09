#!/bin/bash

dir="$(git rev-parse --show-toplevel)"
m4aDir="${dir}/sound/VVC"

mkdir -p $m4aDir
cd $m4aDir
rm m4aList.sh 2> /dev/null

cat "${dir}/list/scene.list" | while read name
do
	name="${name%.*}"
	id="${name%@*}"

	beginTime="${name#*@}"
	endTime=$((beginTime+10))

	input="${m4aDir}/${name%@*}.m4a"
	output="${m4aDir}/${name}.wav"

	echo "ffmpeg -i $input -ss $beginTime -to $endTime -acodec pcm_s16le -ar 48000 -ac 1 $output" | cat >> m4aList.sh
done

chmod +x m4aList.sh
./m4aList.sh
rm m4aList.sh
ls あ* | while read file ; do ffmpeg -i $file -ar 48000 -ac 1 ${file:1} ; done
