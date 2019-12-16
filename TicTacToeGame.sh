#!/bin/bash -x

echo "WELCOME TO TIC TAC TOE GAME"

#declare -A board

function resetBoard()
{
	for (( i=1; i<=9; i++ ))
	do
		board[(($i))]=$i
	done
}
resetBoard
