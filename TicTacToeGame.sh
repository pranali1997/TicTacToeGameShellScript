#!/bin/bash -x

echo "WELCOME TO TIC TAC TOE GAME"

#varaibles
player=0
computer=0
flag=0

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
toss

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
	fi

}

function checkRow()
{
	local flag1=0
	for((i=1;i<=9;))
	do
		if [[ ${board[$i]} -eq ${board[$(($i+1))]} && ${board[$(($i+1))]} -eq ${board[$(($i+2))]} ]]
		then
			flag1=0
			break
		else
			flag1=1
		fi
		i=$(($i+3))

	done
	echo $flag1
}

function checkColumn()
{
	local flag2=0
	for((j=1;j<=3;j++))
	do
		if [[ ${board[$j]} -eq ${board[$(($j+3))]} && ${board[$(($j+6))]} -eq ${board[$j]} ]]
		then
			flag2=0
			break
		else
			flag2=1
		fi

	done
			echo $flag2

}

function checkDiagonals()
{
	flag3=1
		if [[ ${board[1]} -eq ${board[5]} && ${board[1]} -eq ${board[9]} ]]
		then
			flag3=0
		elif [[ ${board[3]} -eq ${board[5]} ]] && [[ ${board[3]} -eq ${board[7]} ]]
		then
			flag3=0
		else
			flag3=1

		fi
			echo $flag3

}

function checkWinner()
{
	i=0
		win1=$(checkRow)
		win2=$(checkColumn)
		win3=$(checkDiagonals)

		if [ $win1 -eq 0 ] || [ $win2 -eq 0 ] || [ $win3 -eq 0 ]
		then
			echo "x wins"
		else
			checkForValidation
		fi
		i=$(($i+1))
}


function displayWinner()
{
	i=0
	while [ $i -lt 9 ]
	do
		displayBoard
		checkForValidation
		flag1=$(checkRow)

		if [ $flag1 -eq 0 ]
		then
			exit
		fi

		flag2=$(checkColumn)

		if [ $flag2 -eq 0 ]
		then
			exit
		fi

		flag3=$(checkDiagonals)
		if [ $flag3 -eq 0 ]
		then
			exit
		fi

		checkResult

		((i++))
	done

}
displayWinner
