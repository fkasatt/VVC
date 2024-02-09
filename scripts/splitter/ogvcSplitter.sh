#!/bin/bash
dir="$(git rev-parse --show-toplevel)"
txtDir="${dir}/OGVC/OGVC_Vol1/Natural/trans"
wavDir="${dir}/OGVC/OGVC_Vol1/Natural/wav"

mkdir -p "${dir}/sound/OGVC"
rm wavList.sh 2> /dev/null

cd $dir

ls $txtDir | while read file
do
	txt="${txtDir}/${file}"
	wav="${wavDir}/${file/\.txt/.wav}"

	cat $txt | while read str
	do
		num="${str:0:3}"
		begin=$(echo $str | awk -F , '{print $2}')
		end=$(echo $str | awk -F , '{print $3}')
		output="${dir}/sound/OGVC/${file%.*}_${num}.wav"

		echo "ffmpeg -i $wav -ss $begin -to $end $output" | cat >> wavList.sh
	done
done

chmod +x splitter.sh
./splitter.sh
rm splitter.sh
