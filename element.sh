#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

GO_OUT() {
  echo I could not find that element in the database.
  FOUND=FALSE
}

READ_VALUES() {
  SYMBOL_INSERTED=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
  NAME_INSERTED=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
  TYPE_INSERTED=$($PSQL "SELECT type FROM types WHERE type_id = (SELECT type_id FROM properties WHERE atomic_number = $1)")
  MASS_INSERTED=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
  MELTING_INSERTED=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
  BOILING_INSERTED=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")

  PRINT_RESULT $1 $SYMBOL_INSERTED $NAME_INSERTED $TYPE_INSERTED $MASS_INSERTED $MELTING_INSERTED $BOILING_INSERTED
}

PRINT_RESULT() {
 #echo $1 $2 $3 $4 $5 $6
 echo "The element with atomic number $1 is $3 ($2). It's a $4, with a mass of $5 amu. $3 has a melting point of $6 celsius and a boiling point of $7 celsius."
}

CLEAN () {
  DELETE_WRONG_PROPERTIES=$($PSQL "DELETE FROM properties WHERE atomic_number=$1")
  DELETE_WRONG_ELEMENTS=$($PSQL "DELETE FROM elements WHERE atomic_number=$1")
}


CLEAN 1000

if [[ $1 ]]
then
  # search for data by number
  if [[ $1 =~ ^[0-9]+$ ]]
  then 
    AN_INSERTED=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    
    # if not found
    if [[ -z $AN_INSERTED ]]
    then
      GO_OUT
    else
      READ_VALUES $AN_INSERTED
    fi
    
    
  elif [[ ${#1} -le 2 ]]
  then
    # Look for the symbol
    AN_INSERTED=$($PSQL "SELECT atomic_number FROM elements WHERE symbol ILIKE '$1'")

    # if not found
    if [[ -z $AN_INSERTED ]]
    then
      GO_OUT
    else
      READ_VALUES $AN_INSERTED
    fi

  else
    # Look for the name
    AN_INSERTED=$($PSQL "SELECT atomic_number FROM elements WHERE name ILIKE '$1'")

    # if not found
    if [[ -z $AN_INSERTED ]]
    then
      GO_OUT
    else
      READ_VALUES $AN_INSERTED
    fi

  fi

else

  # go out without entering data
  echo Please provide an element as an argument.
fi
