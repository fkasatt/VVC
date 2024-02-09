#!/bin/bash

dir="$(git rev-parse --show-toplevel)"
cd "${dir}/chat/text/txt$1"
rm chat.emp 2> /dev/null

tmp=$(mktemp)
emp1=$(cat ${dir}/list/emp1.list)
emp2=$(cat ${dir}/list/emp2.list)
file_num=$(ls -- *.txt | wc -l)
cnt1=1

ls -- *.txt | while read file
do
	cnt2=1
	line=$(cat -- $file | wc -l)

	cat -- $file | while read str
	do
		echo $str | sudachi -a | cat > $tmp
		cat $tmp | rg "$emp1" > /dev/null
		bool=$?

		echo $str | rg "$emp2" > /dev/null
		bool=$((bool * $?))

		if [ $bool -eq 0 ] ; then
			echo $str | rg -v "震え声.?.?$" | rg -v "(レバガチャ|パンダ)" >> chat.emp
		fi

		echo -e "${file}(${cnt1}/${file_num}):\t${cnt2}/${line}"
		cnt2=$((cnt2+1))
	done

	if [ $(cat chat.emp | wc -l) -ge 6 ] ; then
		echo "${file/\.txt/}" | sed 's@^@https://youtu.be/@' >> "${dir}/chat.emp"
		cat chat.emp >> "${dir}/chat/chat.emp"
	fi

	cnt1=$((cnt1+1))
	rm chat.emp 2> /dev/null
done

rm $tmp
cd -
