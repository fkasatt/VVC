#!/bin/bash

dir=$(git rev-parse --show-toplevel)
tmp=$(mktemp)
output=output.csv
mkdir -p "${dir}/data/"

cat "${dir}/OGVC/OGVC_Vol1/Natural/eval/category.txt" | head -20 | awk 'NR>1' | sed 's/,/_/' | sed 's/,/.csv,/' | sed 's/.$//' | cat > tmp

echo "file,label" > $output
cat tmp | while read str
do
	echo $str | rg 'ACC.*ACC' | awk -F, '{printf("%s,ACC\n"), $1}' | cat >> $output
	echo $str | rg 'ANG.*ANG' | awk -F, '{printf("%s,ANG\n"), $1}' | cat >> $output
	echo $str | rg 'ANT.*ANT' | awk -F, '{printf("%s,ANT\n"), $1}' | cat >> $output
	echo $str | rg 'DIS.*DIS' | awk -F, '{printf("%s,DIS\n"), $1}' | cat >> $output
	echo $str | rg 'FEA.*FEA' | awk -F, '{printf("%s,FEA\n"), $1}' | cat >> $output
	echo $str | rg 'JOY.*JOY' | awk -F, '{printf("%s,JOY\n"), $1}' | cat >> $output
	echo $str | rg 'SAD.*SAD' | awk -F, '{printf("%s,SAD\n"), $1}' | cat >> $output
	echo $str | rg 'SUR.*SUR' | awk -F, '{printf("%s,SUR\n"), $1}' | cat >> $output
done
