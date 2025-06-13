#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAIN() {

  RANDOM_NUMBER=$((RANDOM % 1000 + 1))
  
  echo "Enter your username:"
  read USERNAME

  USER_ID=$($PSQL "select id from users where name = '$USERNAME'")

  if [[ $USER_ID ]]
  then
    #get games played
    GAMES_PLAYED=$($PSQL "select count(user_id) from games where user_id = '$USER_ID'")

    #get best game (guess)
    BEST_GUESS=$($PSQL "select min(number_of_guesses) from games where user_id = '$USER_ID'")

    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses."

  else

    echo "Welcome, $USERNAME! It looks like this is your first time here."

    INSERT_USER=$($PSQL "insert into users (name) values ('$USERNAME')")

    USER_ID=$($PSQL "select id from users where name = '$USERNAME'")
  fi

  TRIES=0
  GUESSED=0

  echo -e "\nGuess the secret number between 1 and 1000:"

  while [[ $GUESSED = 0 ]]; do
    read GUESS

    #if not a number
    if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
      echo -e "\nThat is not an integer, guess again:"
    #if correct guess
    elif [[ $RANDOM_NUMBER = $GUESS ]]; then
      TRIES=$(($TRIES + 1))
      echo -e "\nYou guessed it in $TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"
      #insert into db
      INSERTED_TO_GAMES=$($PSQL "insert into games(user_id, random_number, number_of_guesses) values($USER_ID, $RANDOM_NUMBER, $TRIES)")
      GUESSED=1
    #if greater
    elif [[ $RANDOM_NUMBER -gt $GUESS ]]; then
      TRIES=$(($TRIES + 1))
      echo -e "\nIt's higher than that, guess again:"
    #if smaller
    else
      TRIES=$(($TRIES + 1))
      echo -e "\nIt's lower than that, guess again:"
    fi
  done
}

MAIN