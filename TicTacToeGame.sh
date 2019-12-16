#!/bin/bash -x

echo "WELCOME TO TIC TAC TOE GAME"

#varaibles
player=0
computer=0

declare -a board

function resetBoard()
{
	for (( i=1; i<=9; i++ ))
	do
		board[$i]=$i
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
#toss

function displayBoard()
{
		echo " --- --- --- "
		echo "| ${board[1]} | ${board[2]} | ${board[3]} |"
		echo " --- --- --- "
		echo "| ${board[4]} | ${board[5]} | ${board[6]} |"
		echo " --- --- --- "
		echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
		echo " --- --- --- "

}

function checkForValidation()
{
	displayBoard
	flag=0
	read -p "enter a number between 1 to 9 " position
	for (( i=1;i<=9;i++ ))
	do
		if [ $position -eq $i ]
		then
			flag=1
			break
		else
			flag=0
		fi
	done

	if [ $flag -eq 1 ]
	then
	 	board[$i]=X
		displayBoard  ${board[$i]}
	else
		checkForValidation
	fi
}
checkForValidation
