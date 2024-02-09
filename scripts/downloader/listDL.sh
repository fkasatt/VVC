#!/bin/bash
dir=$(git rev-parse --show-toplevel)
file="${dir}/list/url.list"
tmp=$(mktemp)

mkdir -p "${dir}/list"
rm $tmp 2> /dev/null

cat $1 | while read url
do
	yt-dlp --get-id $url -i | sed 's@^@https://youtu.be/@' | cat > $tmp
	cat $tmp | sort | uniq | cat >> $file
done

rm $tmp
