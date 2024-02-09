#!/bin/bash

dir=$(git rev-parse --show-toplevel)
tmp=$(mktemp)
output="${dir}/data/VVC_labels.csv"
cnt=1

echo "id,lavel,audio" > $output

cd "${dir}/VVC/chat/"

cat "${dir}/list/VVC.list" | while read file
do
	ang=0 ; fea=0 ; joy=0 ; sad=0
	cat -- $file | sed 's/.*󱖢//' | while read str
	do
		echo $str | sudachi -a | cat > $tmp

		cat $tmp | rg "(怒る|逆切れ|ぶち切れ|ガチギレ|発狂|キレる|怒り顔|ごめん|プルプル|苛々|やけくそ)" > /dev/null
		bool="$?"
		echo $str | rg "((な|投)げ(キッ?ス|きっ?す)|(した|舌)(う|打)ち|(だい|ダイ|台)(ぱん|パン)|(ふる|震)え声|声(ふる|震)え|(ふる|震)えてて|声(ぷるっ?ぷる|プルッ?プル)|顔真っ赤(で草|じゃん|やん)|(ゆる|許)して|おこ顔)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then ang=$((ang+1)) ; fi

		cat $tmp | rg "(大丈夫|こわい|怖い|困り顔|困惑|気まずい|弱気)" > /dev/null
		bool="$?"
		echo $str | rg "((びび|ビビ)ってい?る|(びび|ビビ)ってて草|(びび|ビビ)(る|ん)な|緊張して(い?る[?？]|んね|て草)|(迷子?|遭難)(してて|で|ってて)草|こっ?わ[っぁー]?|(おちつ|落ち着)(け|いて)|もちつけ|(に|逃)げるな)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then fea=$((fea+1)) ; fi

		cat $tmp | rg "(喜ぶ|笑う|微笑ましい|爆笑|笑顔|優しい|煩い|興奮|熱弁|大喜び|楽しい|イキる|ドヤ顔|イキイキ|ニヤニヤ|きもい)" > /dev/null
		bool="$?"
		echo $str | rg "(早口(で草|じゃん|やん)|限界化|限界オタク(で|に)|うっざ|ウッザ|(あお|煽)(りよる|ってんね|るな|り散らかし|てて草)|にっ?こにこ|ニッ?コニコ|うっ?きうき|ウッ?キウキ|調子(の|乗)(る|って)|なにわろ|なに(笑)(て|と)ん|(わら|笑)い(かた|方)|楽しみ(だ|や)(な|ね)|(うれ|嬉)し(いね|そう)|照れ顔)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then joy=$((joy+1)) ; fi

		cat $tmp | rg "(悲しい|泣く|しょんぼり|泣き顔|後悔|可哀想|寂しい|惜しい|怠い|大丈夫|動揺)" > /dev/null
		bool="$?"
		echo $str | rg "((い|生)き(ろ|て)|(し|死)(ぬな|なないで|ぬんだぁ|なんで)|(なみだ|涙)(拭|吹|ふ)(けよ|きな|いて)|(こわ|壊)れ(た|ちゃった|ないで)|無理(せず|せんで|すん?な|は?しないで)|そんなことないよ?|がんばったね?|おっも|(めんど|面倒)(くさ|臭|草)|つれぇな|(辛|つら)(そう|いな|いね)|大変だ(ぁ|あ|ァな|ったな)|(せつ|切)ないね|(えも|エモ)いね)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then sad=$((sad+1)) ; fi

		total=$((ang+fea+joy+sad))
		echo -e "${total:-0}\n${ang:-0}\n${fea:-0}\n${joy:-0}\n${sad:-0}" > eval.tmp
	done

	if [ $(cat eval.tmp | head -1) -eq 0 ] ; then
		echo $file >> error.log
	else
		total=$(cat -- $file | wc -l)

		id=${file%%.*}
		if [ $(echo "scale=2; $(cat eval.tmp | awk 'NR==2') / $total * 100" | bc | sed 's/\..*//') -ge 50 ] ; then
			echo "${id},ANG,${id}.wav" >> $output
		fi
		if [ $(echo "scale=2; $(cat eval.tmp | awk 'NR==3') / $total * 100" | bc | sed 's/\..*//') -ge 50 ] ; then
			echo "${id},FEA,${id}.wav" >> $output
		fi
		if [ $(echo "scale=2; $(cat eval.tmp | awk 'NR==4') / $total * 100" | bc | sed 's/\..*//') -ge 50 ] ; then
			echo "${id},JOY,${id}.wav" >> $output
		fi
		if [ $(echo "scale=2; $(cat eval.tmp | awk 'NR==5') / $total * 100" | bc | sed 's/\..*//') -ge 50 ] ; then
			echo "${id},SAD,${id}.wav" >> $output
		fi
	fi

	echo "$cnt/2400"
	cnt=$((cnt+1))
done

rm eval.tmp
