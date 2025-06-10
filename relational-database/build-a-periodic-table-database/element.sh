#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ELEMENT="$1"

INFO() {

  if [[ $1 -eq 3 ]]
  then
    echo "$2"
    exit;
  elif [[ $1 -eq 1 ]]
  then
    ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where atomic_number = $2")
  elif [[ $1 -eq 2 ]]
  then
    ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol = '$2' or name = '$2'")
  fi

  NAME=$($PSQL "select name from elements where atomic_number = $ATOMIC_NUMBER")
  SYMBOL=$($PSQL "select symbol from elements where atomic_number = $ATOMIC_NUMBER")
  ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number = $ATOMIC_NUMBER")
  TYPE_ID=$($PSQL "select type_id from properties where atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "select type from types where type_id = $TYPE_ID")

  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
}

if [[ -z $ELEMENT ]]
then
  echo "Please provide an element as an argument."
else
  LENGTH=${#ELEMENT}

  if [[ $ELEMENT =~ ^[0-9]+$ ]]
  then
    RESULT=$($PSQL "select atomic_number from elements where atomic_number = $ELEMENT")

    if [[ ! -z $RESULT ]]
    then
      INFO 1 $ELEMENT
    fi
  else
    RESULT=$($PSQL "select atomic_number from elements where symbol = '$ELEMENT' or name = '$ELEMENT'")

    if [[ ! -z $RESULT ]]
    then
      INFO 2 $ELEMENT
    fi
  fi

  if [[ -z $RESULT ]]
  then
    INFO 3 "I could not find that element in the database."
  fi
  
fi