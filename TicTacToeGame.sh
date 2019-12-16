#!/bin/bash -x

echo "WELCOME TO TIC TAC TOE GAME"

#varaibles
player=0
computer=0

function resetBoard()
{
	for (( i=1; i<=9; i++ ))
	do
		board[(($i))]=$i
	done
}
resetBoard

function toss()
{
	letter=$((RANDOM%2))
	if [ $letter -eq 1 ]
	then
		player="X"
		echo "Player will play first"
	else
		player="O"
		echo "computer will play first"
	fi
}
toss
