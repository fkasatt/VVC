#!/bin/bash

dir=$(git rev-parse --show-toplevel)
tmp=$(mktemp)
output="${dir}/data/OGVC_labels.csv"
mkdir -p "${dir}/data/"

cat "${dir}/OGVC/OGVC_Vol1/Natural/eval/category.txt" | awk 'NR>1' | sed 's/,/_/' | sed 's/,/.csv,/' | sed 's/.$//' | cat > $tmp

echo "id,label,audio" > $output
cat $tmp | while read str
do
	echo $str | rg 'ANG.*ANG' | awk -F, '{printf("%s,ANG\n"), $1}' | cat >> $output
	echo $str | rg 'FEA.*FEA' | awk -F, '{printf("%s,FEA\n"), $1}' | cat >> $output
	echo $str | rg 'JOY.*JOY' | awk -F, '{printf("%s,JOY\n"), $1}' | cat >> $output
	echo $str | rg 'SAD.*SAD' | awk -F, '{printf("%s,SAD\n"), $1}' | cat >> $output
done
