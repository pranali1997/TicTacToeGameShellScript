#!/bin/bash -x

echo "WELCOME TO TIC TAC TOE GAME"

#variables
player=0
computer=0
flag=0
willPlay1=""
willPlay2=""

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
		computer="O"
	else
		player="O"
		computer="X"
	fi
	echo $player
}

willPlay1=$(toss)
	if [ $willPlay1 == "X" ]
	then
		willPlay2="O"
	else
		willPlay2="X"
	fi

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
			if [[ $position -eq $i && $position != "X" && $position != "O" ]]
			then
				board[$i]=$willPlay1
				displayBoard  ${board[$i]}
			break
				checkForValidation
				flag=0
			fi
		done

		for (( i=1;i<=9;i++ ))
		do
			computerPos=$((RANDOM%9+1))
			if [[ $computerPos -eq $i && $computerPos != "X" && $computerPos != "O" ]]
			then
				board[$i]=$willPlay2
				displayBoard  ${board[$i]}
			break
				checkForValidation
				flag=0
			fi
		done
	if [[ $flag -ne 0 && $position == "X" && $computerPos == "O" && $computerPos == "X" && $position == "O" ]]
	then
		echo "again"
		displayWinner
	else
		echo "value"
	fi
}


function checkRow()
{
	local flag1=0
	for((i=1;i<=9;))
	do
	if [[ ${board[$i]} -eq ${board[$(($i+1))]} && ${board[$(($i+1))]} -eq ${board[$(($i+2))]} ]] && [[ ${board[$i]} != "X" || ${board[$i]} != "O" ]]
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
		if [[ ${board[$j]} -eq ${board[$(($j+3))]} && ${board[$(($j+6))]} -eq ${board[$j]} ]] && [[ ${board[$j]} != "X" || ${board[$]} != "O" ]]
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
		if [[ ${board[1]} -eq ${board[5]} && ${board[1]} -eq ${board[9]} ]] && [[ ${board[1]} != "X" || ${board[1]} != "O" ]]
		then
			flag3=0
		elif [[ ${board[3]} -eq ${board[5]} ]] && [[ ${board[3]} -eq ${board[7]} ]] && [[ ${board[3]} != "X" || ${board[3]} != "O" ]]
		then
			flag3=0
		else
			flag3=1

		fi
			echo $flag3

}

function checkOpponentRow()
{
	for((i=1;i<=9;))
	do
		if [[ ${board[$i]} -eq ${board[$(($i+1))]} && ${board[$i]}==$willPlay1 ]] 
		then
			board[$(($i+2))]=$willPlay2
		elif [[ ${board[$i]} -eq ${board[$(($i+2))]} && ${board[$i]}==$willPlay1 ]]
		then
			board[$(($i+1))]=$willPlay2
		elif [[ ${board[$(($i+1))]} -eq ${board[$(($i+2))]} && ${board[$(($i+1))]}==$willPlay1 ]]
		then
			board[$i]=$willPlay2
		fi

		i=$(($i+3))
	done


}

function checkOpponentColumn()
{
	for((i=1;i<=3;i++))
	do
		if [[ ${board[$i]} -eq ${board[$(($i+3))]} && ${board[$i]}==$willPlay1 ]] 
		then
			board[$(($i+6))]=$willPlay2
		elif [[ ${board[$i]} -eq ${board[$(($i+6))]} && ${board[$i]}==$willPlay1 ]]
		then
			board[$(($i+3))]=$willPlay2
		elif [[ ${board[$(($i+3))]} -eq ${board[$(($i+6))]} && ${board[$(($i+1))]}==$willPlay1 ]]
		then
			board[$i]=$willPlay2
		fi
	done


}

function checkOpponentDiagonals()
{
		if [[ ${board[1]} -eq ${board[5]} && ${board[1]}==$willPlay1 ]]
		then
			board[9]=$willPlay2
		elif [[ ${board[9]} -eq ${board[5]} && ${board[5]}==$willPlay1 ]]
		then
			board[1]=$willPlay2
		elif [[ ${board[5]} -eq ${board[7]} && ${board[5]}==$willPlay1 ]]
		then
			board[3]=$willPlay2
		elif [[ ${board[3]} -eq ${board[7]} && ${board[3]}==$willPlay1 ]]
		then
			board[5]=$willPlay2
		fi
			echo $flag3

}


function checkWinner()
{
		win1=$(checkRow)
		win2=$(checkColumn)
		win3=$(checkDiagonals)

		if [ $win1 -eq 0 ] || [ $win2 -eq 0 ] || [ $win3 -eq 0 ]
		then
			echo "x wins"
		else
			checkForValidation
		fi
}


function displayWinner()
{
	i=0
	while [ $i -le 9 ]
	do
		checkOpponentRow
		checkOpponentColumn
 		checkOpponentDiagonals
		checkForValidation
		displayBoard
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

		checkWinner
		displayBoard
		((i++))
	done

}
displayWinner

