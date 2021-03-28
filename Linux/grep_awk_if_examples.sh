#!/bin/bash

## This script searches a schedule file for a firstname+lastname to list what games this employee has worked


#roulette_dealer_finder_by_time.sh "Firstname Lastname"
#input format is quotations with first name, space, last name


#echo "$1"
#cat *Dealer_schedule | grep "$1" |

#awk '{print $1, $3, $4, "Game1"}' | grep "$1" | cat



#roulette_dealer_finer_by_time_and_game.sh "HH:MM:SS AM" dddd game
#game options are: blackjack, texas, roulette



if [[ "$3" == "blackjack" ]]; then
 cat "$2_Dealer_schedule" | grep "$1" | awk '{print $3, $4}'
elif [[ "$3" == "texas" ]]; then
 cat "$2_Dealer_schedule" | grep "$1" | awk '{print $7, $8}'
elif [[ "$3" == "roulette" ]]; then
cat "$2_Dealer_schedule" | grep "$1" | awk '{print $5, $6}'
else
 echo "wrong option for game"
fi
