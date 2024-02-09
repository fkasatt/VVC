#!/bin/bash
dir=$(git rev-parse --show-toplevel)
sceneDir="${dir}/chat/scene"
listDir="${dir}/list"
tmp1=$(mktemp)
tmp2=$(mktemp)
cd $sceneDir

lines=$(cat "${listDir}/scene.list" | wc -l)
cnt=1

cat "${listDir}/scene.list" | while read file
do
	acc=0 ; ang=0 ; ant=0 ; dis=0 ; fea=0 ; joy=0 ; sad=0 ; sur=0

	cat -- $file | sed 's/.*󱖢//' | while read str
	do
		echo $str | sudachi -a | cat > $tmp1

		cat $tmp1 | rg "(微笑ましい|優しい|強気|きもい)" > /dev/null
		bool="$?"
		echo $str | rg "(納得して|(めんど|面倒)(くさ|臭|草)|(あま|甘)え(る|ん)な|(せつ|切)ないね|(えも|エモ)いね|おこ顔|(うれ|嬉)し(いね|そう))" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then acc=$((acc+1)) ; fi

		cat $tmp1 | rg "(怒る|自爆|自滅|嫉妬|ドン引き|逆切れ|ぶち切れ|ガチギレ|発狂|キレる|怒り顔|ごめん|プルプル|苛々|やけくそ)" > /dev/null
		bool="$?"
		echo $str | rg "((な|投)げ(キッ?ス|きっ?す)|(した|舌)(う|打)ち|(だい|ダイ|台)(ぱん|パン)|(ふる|震)え声|声(ふる|震)え|(ふる|震)えてて|声(ぷるっ?ぷる|プルッ?プル)|顔真っ赤(で草|じゃん|やん)|(ゆる|許)して|おこ顔)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then ang=$((ang+1)) ; fi

		cat $tmp1 | rg "(困り顔|困惑|気まずい|無慈悲|辛辣|半笑い|イキる|ドヤ顔|イキイキ|葛藤|強気|ニヤニヤ)" > /dev/null
		bool="$?"
		echo $str | rg "(うっざ|ウッザ|(あお|煽)(りよる|ってんね|るな|り散らかし|てて草)|にっ?こにこ|ニッ?コニコ|うっ?きうき|ウッ?キウキ|緊張して(い?る[?？]|んね|て草)|調子(の|乗)(る|って)|(迷子?|遭難)(してて|で|ってて)草|寝(て|よう|な)|眠そう|ゆっくりして[^い]|ゆっくり(で|も)|(げんき|元気)([?？]|(だ|出)して)|乾いた笑い|楽しみ(だ|や)(な|ね))" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then ant=$((ant+1)) ; fi

		cat $tmp1 | rg "(自爆|自滅|嫉妬|ドン引き|苛々|発狂|無慈悲|後悔|辛辣|半笑い|弱気|葛藤|怠い)" > /dev/null
		bool="$?"
		echo $str | rg "((びび|ビビ)ってい?る|(びび|ビビ)ってて草|(びび|ビビ)(る|ん)な|(こわ|壊)れ(た|ちゃった|ないで)|(いや|嫌)そう|無理(せず|せんで|すん?な|は?しないで)|そんなことないよ?|がんばったね?|乾いた笑い|つれぇな|(辛|つら)(そう|いな|いね)|大変だ(ぁ|あ|ァな|ったな)|気に(しないで|すんな|しなくても)|(おちつ|落ち着)(け|いて)|もちつけ|(に|逃)げるな)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then dis=$((dis+1)) ; fi

		cat $tmp1 | rg "(大丈夫|こわい|怖い|動揺|困り顔|困惑|気まずい|弱気)" > /dev/null
		bool="$?"
		echo $str | rg "((びび|ビビ)ってい?る|(びび|ビビ)ってて草|(びび|ビビ)(る|ん)な|(い|生)き(ろ|て)|(し|死)(ぬな|なないで|ぬんだぁ|なんで)|緊張して(い?る[?？]|んね|て草)|(迷子?|遭難)(してて|で|ってて)草|寝(て|よう|な)|眠そう|ゆっくりして[^い]|ゆっくり(で|も)|(げんき|元気)([?？]|(だ|出)して)(あま|甘)え(る|ん)な|こっ?わ[っぁー]?|気に(しないで|すんな|しなくても))" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then fea=$((fea+1)) ; fi

		cat $tmp1 | rg "(喜ぶ|笑う|微笑ましい|爆笑|笑顔|優しい|煩い|興奮|熱弁|大喜び|楽しい|イキる|ドヤ顔|イキイキ|ニヤニヤ|きもい)" > /dev/null
		bool="$?"
		echo $str | rg "(早口(で草|じゃん|やん)|限界化|限界オタク(で|に)|うっざ|ウッザ|(あお|煽)(りよる|ってんね|るな|り散らかし|てて草)|にっ?こにこ|ニッ?コニコ|うっ?きうき|ウッ?キウキ|お?[き気][づ付ず](きに|く|いて|いたか|いた[?？])|にっ?こにこ|ニッ?コニコ|うっ?きうき|ウッ?キウキ|調子(の|乗)(る|って)|なにわろ|なに(笑)(て|と)ん|(わら|笑)い(かた|方)|楽しみ(だ|や)(な|ね)|(うれ|嬉)し(いね|そう)|照れ顔)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then joy=$((joy+1)) ; fi

		cat $tmp1 | rg "(悲しい|泣く|しょんぼり|泣き顔|後悔|可哀想|寂しい|ごめん|惜しい|怠い|プルプル|逆切れ|ぶち切れ|ガチギレ|発狂|キレる)" > /dev/null
		bool="$?"
		echo $str | rg "((い|生)き(ろ|て)|(し|死)(ぬな|なないで|ぬんだぁ|なんで)|(なみだ|涙)(拭|吹|ふ)(けよ|きな|いて)|(こわ|壊)れ(た|ちゃった|ないで)|無理(せず|せんで|すん?な|は?しないで)|そんなことないよ?|がんばったね?|おっも|(めんど|面倒)(くさ|臭|草)|つれぇな|(辛|つら)(そう|いな|いね)|大変だ(ぁ|あ|ァな|ったな)|(せつ|切)ないね|(えも|エモ)いね)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then sad=$((sad+1)) ; fi

		cat $tmp1 | rg "(大丈夫|驚く|動揺|煩い|興奮|熱弁|可哀想|惜しい|やけくそ)" > /dev/null
		bool="$?"
		echo $str | rg "((な|投)げ(キッ?ス|きっ?す)|(した|舌)(う|打)ち|(だい|ダイ|台)(ぱん|パン)|(ふる|震)え声|声(ふる|震)え|(ふる|震)えてて|声(ぷるっ?ぷる|プルッ?プル)|早口(で草|じゃん|やん)|限界化|限界オタク(で|に)|お?[き気][づ付ず](きに|く|いて|いたか|いた[?？])|(おちつ|落ち着)(け|いて)|もちつけ|(に|逃)げるな)" > /dev/null
		bool=$((bool * $?))
		if [ $bool -eq 0 ] ; then sur=$((sur+1)) ; fi

		total=$((acc+ang+ant+dis+fea+joy+sad+sur))
		echo -e "${total}\n${acc}\n${ang}\n${ant}\n${dis}\n${fea}\n${joy}\n${sad}\n${sur}" > $tmp2
	done

	total=$(cat $tmp2 | head -1)
	if [ $total -eq 0 ] ; then
		echo $file >> error.log
	else
		acc=$(echo "scale=2; $(cat $tmp2 | awk 'NR==2') / $total * 100" | bc)
		ang=$(echo "scale=2; $(cat $tmp2 | awk 'NR==3') / $total * 100" | bc)
		ant=$(echo "scale=2; $(cat $tmp2 | awk 'NR==4') / $total * 100" | bc)
		dis=$(echo "scale=2; $(cat $tmp2 | awk 'NR==5') / $total * 100" | bc)
		fea=$(echo "scale=2; $(cat $tmp2 | awk 'NR==6') / $total * 100" | bc)
		joy=$(echo "scale=2; $(cat $tmp2 | awk 'NR==7') / $total * 100" | bc)
		sad=$(echo "scale=2; $(cat $tmp2 | awk 'NR==8') / $total * 100" | bc)
		sur=$(echo "scale=2; $(cat $tmp2 | awk 'NR==9') / $total * 100" | bc)
	fi

	if [ ${acc%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/acc.list
	fi
	if [ ${ang%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/ang.list
	fi
	if [ ${ant%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/ant.list
	fi
	if [ ${dis%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/dis.list
	fi
	if [ ${fea%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/fea.list
	fi
	if [ ${joy%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/joy.list
	fi
	if [ ${sad%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/sad.list
	fi
	if [ ${sur%%.*} -gt 40 ] ; then
		echo $file | cat >> ${listDir}/sur.list
	fi

	echo "${cnt}/${lines}"
	cnt=$((cnt+1))
done

rm $tmp2
