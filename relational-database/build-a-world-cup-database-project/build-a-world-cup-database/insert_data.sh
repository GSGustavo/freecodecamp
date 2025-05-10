#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "truncate teams, games")

# year,round,winner,opponent,winner_goals,opponent_goals
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  if [[ $YEAR != year ]]
  then
    
    WINNER_ID=$($PSQL "select team_id from teams where name = '$WINNER'")

    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams (name) values ('$WINNER')");

      if [[ $INSERT_WINNER_RESULT = 'INSERT 0 1' ]]
      then
        echo Inserted into teams, $WINNER
      fi

      WINNER_ID=$($PSQL "select team_id from teams where name = '$WINNER'")
    fi

    OPPONENT_ID=$($PSQL "select team_id from teams where name = '$OPPONENT'")

    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams (name) values ('$OPPONENT')");

      if [[ $INSERT_OPPONENT_RESULT = 'INSERT 0 1' ]]
      then
        echo Inserted into teams, $OPPONENT
      fi

      OPPONENT_ID=$($PSQL "select team_id from teams where name = '$OPPONENT'")
    fi

    INSERT_GAME_RESULT=$($PSQL "insert into games (year, winner_id, OPPONENT_id, winner_goals, OPPONENT_goals, round) 
    values ($YEAR, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS, '$ROUND')")

    if [[ $INSERT_GAME_RESULT = 'INSERT 0 1' ]]
    then
      echo Inserted game, $WINNER x $OPPONENT!
    fi
  fi

done