#!/bin/bash
dir=$(git rev-parse --show-toplevel)

while true
do
	file=$(cat check.list | head -1)
	nvim -- $file
	cat $list | awk 'NR>1' | cat > tmp
	cat tmp | cat > check.list
done

rm tmp
