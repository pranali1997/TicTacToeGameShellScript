#!/bin/bash -x

echo "WELCOME TO TIC TAC TOE GAME"

function resetBoard()
{
	for (( i=1; i<=9; i++ ))
	do
		board[(($i))]=$i
	done
}
resetBoard

function assignedLetter()
{
	letter=$((RANDOM%2))
	if [ $letter -eq 1 ]
	then
		echo "Letter X"
	else
		echo "Letter O"
	fi
}
assignedLetter
