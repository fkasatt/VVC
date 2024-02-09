#!/bin/bash

dir=$(git rev-parse --show-toplevel)

file="${dir}/chat/chat.emp"
dir="${dir}/chat/scene"
tmp=$(mktemp)
mkdir -p $dir

cat $file | 
	# 前のコメントから3秒以内かつ最初のコメントから10秒以内のコメントを抽出する
	awk -F'󱖢' 'BEGIN { ORS="" } { if ($1 ~ /^h/) { print $1 "\n" } else if (prev ~ /^h/) { start = $1 } else { diff = $1 - prev ; passed = $1 - start ; if (diff < 2000 && passed < 10000) { print FNR-1 "\n" FNR "\n" } else { print "" ; start = $1 } } prev = $1 }' | 
	sed 's/*//' | sed -E 's//\n/' | uniq -u | 
	awk '{ if ($1 ~ /^h/) { print $1 } else if ($1 ~ // || prev ~ //) {} else if ($1 - prev >= 3) { print prev "," $1 } prev = $1 }' | 
	sed -E 's/^(https.*),[0-9]+/\1/' | rg -v '^,' | uniq | 
	# URL行が連続する場合、つまりコメントを抽出できなかった動画のURLを削除する
	awk '{if (prev !~ /^h/ && $1 ~ /^h/) { url = $1 } else if (prev ~ /^h/ && $1 ~ /^h/) { url = $1 } else if (prev ~ /^h/ && $1 !~ /^h/) { print url "\n" $1 } else { print $1 }  prev = $1}' | 
	cat > $tmp

total=$(cat $tmp | wc -l)
cnt=1
cat $tmp | while read str
do
	if [ -z ${str%%h*} ] ; then
		url="${str}?t="
	else
		begin="${str%,*}"
		end="${str#*,}"

		# 開始時刻を得る
		beginTime="$(cat $file |sed -n "${begin}p")"
		beginTime="${beginTime%󱖢*}"
		beginTime="${beginTime::-3}"
		beginTime="$((beginTime-10))"

		# sceneファイル名を得る
		output="${url##*\/}"
		output="${dir}/${output%\?*}@${beginTime}.scene"

		# sceneファイルを出力
		cat $file | sed -n "${begin},${end}p" | head -20 >> "${output}"
	fi

	echo "${cnt}/${total}"
	cnt=$((cnt+1))
done

ls -- "${dir}/*.scene" | cat > "$(git rev-parse --show-toplevel)/list/scene.list"
rm $tmp
