#!/bin/bash
cat $1 | sed 's/@../&@/' | sed 's/@//' | sed 's/.@.\./@&/' | 
	sed 's/@/#/' | sed 's/@//' | sed 's/#/@/' | 
	awk -F@ '!seen[$1]++' | 
	sed 's/^.........../&@/' | sed 's/@/#/' | sed 's/@//' | sed 's/#/@/'
