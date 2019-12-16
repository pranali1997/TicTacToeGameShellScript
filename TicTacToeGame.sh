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
#	displayBoard
	local flag=0
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

function checkRow()
{
	local flag=0
	checkForValidation
	for((i=1;i<=9;))
	do
		if [[ board[$i] -eq board[$(($i+1))] && board[$(($i+1))] -eq board[$(($i+2))] ]]
		then
			flag=0
			break
		else
			flag=1
		fi
		i=$(($i+3))

	done

	if [ $flag -eq 0 ]
	then
		echo 0
	else
		checkRow
	fi
}

function checkColumn()
{
	local flag=0
	checkForValidation
	for((j=1;j<=3;j++))
	do
		if [[ board[$j] -eq board[$(($j+3))] && board[$(($j+6))] -eq board[$j] ]]
		then
			flag=0
			break
		else
			flag=1
		fi

	done

	if [ $flag -eq 0 ]
	then
		echo 0
	else
		checkColumn
	fi
}

function checkDiagonals()
{
	local flag=0
	checkForValidation
	for((j=1;j<=3;j++))
	do
		if [[ board[$j] -eq board[$(($j+4))] && board[$(($j+4))] -eq board[$(($j+8))] ]] ||  [[ board[$j] -eq board[$(($j+2))] && board[$(($j+2))] -eq board[$(($j+4))] ]]
		then
			flag=0
			break
		else
			flag=1
		fi

	done

	if [ $flag -eq 0 ]
	then
		echo 0
	else
		checkDiagonals
	fi
}

function checkResult()
{
win1=$(checkRow)
win2=$(checkColumn)
win3=$(checkDiagonals)

if [ $win1 -eq 0 && $win2 -eq 0 && $win3 -eq 0 ]
then
		echo "X wins"
else
		echo "wrong"
fi
}
checkResult
