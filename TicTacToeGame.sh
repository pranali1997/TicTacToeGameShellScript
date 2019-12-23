#!/bin/bash -x

echo "WELCOME TO TIC TAC TOE GAME"

#variables
player=0
computer=0
flag=1
playerSymbol1=""
playerSymbol2=""
blockOpponent=0

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

playerSymbol1=$(toss)
if [ $playerSymbol1 == "X" ]
then
	playerSymbol2="O"
else
	playerSymbol2="X"
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

function checkCorners()
{
	cornerCompValue=$(((RANDOM%4)+1))
	if [ $cornerCompValue -eq 1 ]
	then
		blockValue=1
	elif [ $cornerCompValue -eq 2 ]
	then
		blockValue=3
	elif [ $cornerCompValue -eq 3 ]
	then
		blockValue=7
	elif [ $cornerCompValue -eq 4 ]
	then
		blockValue=9
	fi
	echo $blockValue
}

function checkCentre()
{
	blockValue=5
	echo $blockValue
}

function checkSides()
{
	cornerCompValue=$((RANDOM%4))
	if [ $cornerCompValue -eq 1 ]
	then
		bloackValue=1
	elif [ $cornerCompValue -eq 2 ]
	then
		blockValue=3
	elif [ $cornerCompValue -eq 3 ]
	then
		blockValue=7
	elif [ $cornerCompValue -eq 4 ]
	then
		blockValue=9
	fi
	echo $blockValue
}


function userAndComputerPlay()
{
	read -p "enter a number between 1 to 9 " position
	for (( i=1;i<=9;i++ ))
	do

		if [[ $position -eq $i && ${board[$position]}!=$playerSymbol1 && ${board[$position]}!=$playerSymbol2 ]]
		then
			board[$i]=$playerSymbol1
			displayBoard  ${board[$i]}
			flag=0
			break
		fi
	done
	for (( i=1;i<=9;i++ ))
	do
			i=$(checkCorners)
			if [[ ${board[$i]} != $playerSymbol1 && ${board[$i]} != $playerSymbol2 ]]
			then
				board[$i]=$playerSymbol2
				displayBoard ${board[$i]}
				flag=0
				break
			fi
			i=$(checkCentre)
			if [[ ${board[$i]} -eq $i && ${board[$i]} != $playerSymbol1 && ${board[$i]} != $playerSymbol2 ]]
			then
				board[$i]=$playerSymbol2
				displayBoard ${board[$i]}
				flag=0
				break
			fi
			i=$(checkSides)
			if [[ ${board[$i]} -eq $i && ${board[$i]} != $playerSymbol1 && ${board[$i]} != $playerSymbol2 ]]
			then
				board[$i]=$playerSymbol2
				displayBoard  ${board[$i]}
				flag=0
				break
			fi
	done

	if [[ $flag -ne 0 && ${board[$position]}==$playerSymbol1 && ${board[$i]}==$playerSymbol2 && ${board[$i]}==$playerSymbol1 && ${board[$position]}==$playerSymbol2 ]]
	then
		echo "again"
		displayWinner
	else
		echo "value"
	fi
}


function checkRow()
{
	flag1=0
	for (( i=1;i<=9; ))
	do
		if [[ ${board[$i]} -eq ${board[(($i+1))]} && ${board[(($i+1))]} -eq ${board[(($i+2))]} ]] && [[ ${board[$i]} != $playerSymbol1 || ${board[$i]}!=$playerSymbol2 ]]
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
	flag2=0
	for((j=1;j<=3;j++))
	do
		if [[ ${board[$j]} -eq ${board[$(($j+3))]} && ${board[$(($j+6))]} -eq ${board[$j]} ]] && [[ ${board[$i]}=$playerSymbol1 || ${board[$j]}!=$playerSymbol2 ]]
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
	if [[ ${board[1]} -eq ${board[5]} && ${board[1]} -eq ${board[9]} ]] && [[ ${board[1]} == $playerSymbol1 ]]
	then
		flag3=0
	elif [[ ${board[3]} -eq ${board[5]} ]] && [[ ${board[3]} -eq ${board[7]} ]] && [[ ${board[3]} == $playerSymbol1 ]]
	then
		flag3=0
	else
		flag3=1

	fi
	if [[ ${board[1]} -eq ${board[5]} && ${board[1]} -eq ${board[9]} ]] && [[ ${board[1]} == $playerSymbol2 ]]
	then
		flag3=0
	elif [[ ${board[3]} -eq ${board[5]} ]] && [[ ${board[3]} -eq ${board[7]} ]] && [[ ${board[3]} == $playerSymbol2 ]]
	then
		flag3=0
	else
		flag3=1
	fi

		echo $flag3

}

function checkOpponentRow()
{
if [ $blockOpponent -eq 0 ]
then
	for((i=1;i<=9;))
	do
		if [[ ${board[$i]} -eq ${board[$(($i+1))]} && ${board[$i]}==$playerSymbol1 ]]
		then
			board[$(($i+2))]=$playerSymbol2
		elif [[ ${board[$i]} -eq ${board[$(($i+2))]} && ${board[$i]}==$playerSymbol1 ]]
		then
			board[$(($i+1))]=$playerSymbol2
		elif [[ ${board[$(($i+1))]} -eq ${board[$(($i+2))]} && ${board[$(($i+1))]}==$playerSymbol1 ]]
		then
			board[$i]=$playerSymbol2
		fi

		i=$(($i+3))
	done
	blockOpponent=1
fi

}

function checkOpponentColumn()
{
if [ $blockOpponent -eq 0 ]
then
	for((i=1;i<=3;i++))
	do
		if [[ ${board[$i]} -eq ${board[$(($i+3))]} && ${board[$i]}==$playerSymbol1 ]] 
		then
			board[$(($i+6))]=$playerSymbol2
		elif [[ ${board[$i]} -eq ${board[$(($i+6))]} && ${board[$i]}==$playerSymbol1 ]]
		then
			board[$(($i+3))]=$playerSymbol2
		elif [[ ${board[$(($i+3))]} -eq ${board[$(($i+6))]} && ${board[$(($i+1))]}==$playerSymbol1 ]]
		then
			board[$i]=$playerSymbol2
		fi
	done
	blockOpponent=1
fi

}

function checkOpponentDiagonals()
{
	if [ $blockOpponent -eq 0 ]
	then
		if [[ ${board[1]} -eq ${board[5]} && ${board[1]}==$playerSymbol1 ]]
		then
			board[9]=$playerSymbol2
		elif [[ ${board[9]} -eq ${board[5]} && ${board[5]}==$playerSymbol1 ]]
		then
			board[1]=$playerSymbol2
		elif [[ ${board[5]} -eq ${board[7]} && ${board[5]}==$playerSymbol1 ]]
		then
			board[3]=$playerSymbol2
		elif [[ ${board[3]} -eq ${board[7]} && ${board[3]}==$playerSymbol1 ]]
		then
			board[5]=$playerSymbol2
		fi
		blockOpponent=1
	fi
		echo $flag3
}

function displayWinner()
{
	i=0
	while [ $i -le 9 ]
	do
		displayBoard
		checkOpponentRow
		checkOpponentColumn
 		checkOpponentDiagonals
		userAndComputerPlay
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
		((i++))
		if [ $i -ge 9 ]
		then
			echo "It's a tie..."
		fi
	done



}
displayWinner
