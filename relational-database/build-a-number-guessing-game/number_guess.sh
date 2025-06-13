#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

USER_GUESS=""

MAIN() {

  RANDOM_NUMBER=$((RANDOM % 1000 + 1))
  
  echo "Enter your username:"
  read USERNAME

  USER_RESULT=$($PSQL "select name from users where name = '$USERNAME'")

  if [[ -z $USER_RESULT ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  else
    echo "Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses."
  fi

  while [ ! $RANDOM_NUMBER -eq $USER_GUESS ]
  do
    GENNUMBER

    if [[ $RANDOM_NUMBER < $USER_GUESS ]]
    then 
      echo "It's lower than that, guess again:"
    elif [[ $RANDOM_NUMBER > $USER_GUESS ]]
    then
      echo "It's higher than that, guess again:"
    fi
  done

  echo "You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!"
  

}

GENNUMBER() {

  if [[ ! -z $1 ]]
  then
    echo $1
  fi

  echo "Guess the secret number between 1 and 1000:"
  read USER_GUESS

  if [[ ! "$USER_GUESS" =~ ^[0-9]+$ ]] && ! (( USER_GUESS >= 1 && USER_GUESS <= 1000 ))
  then
    GENNUMBER "That is not an integer, guess again:"
  fi

}

MAIN
