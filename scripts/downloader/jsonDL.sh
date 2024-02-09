#!/bin/bash

# jsonファイルを格納するディレクトリ
dir="$(git rev-parse --show-toplevel)"
mkdir -p "$dir/chat"
mkdir -p "$dir/chat/json"
dir="${dir}/chat/json"

cat $1 | while read url	# urlリストから1行ずつ取り出す
do
	yt-dlp -N 8 -i --write-subs --skip-download -o "%(id)s" $url	# チャットのみをダウンロードする/チャットがない等のエラーは無視する

	id=${url##*/}					# URLから動画IDを取り出す(`.*=`の最長一致を削除)
	file="${id}.live_chat.json"	# yt-dlpがダウンロードした(筈の)ファイルの名前

	if [ -f $file ] ; then							# ファイルが存在する場合
		cat -- "${file}" | jq > "${dir}/${id}.json"	# jqに掛けた上で格納
	fi

	rm $file
done
