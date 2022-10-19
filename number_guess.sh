#!/bin/bash
clear

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


echo "Enter your username:"
read USERNAME

#######################
# SEARCH FOR THE USER #
#######################

# try to find it
USERNAME_ID=$($PSQL "SELECT gamer_id FROM users WHERE name ILIKE '$USERNAME'")

# if found
if [[ $USERNAME_ID ]]
then
  COUNT_GAMES=$($PSQL "SELECT COUNT(tries) FROM games WHERE gamer_id = $USERNAME_ID")
  BEST_TRY=$($PSQL "SELECT MIN(tries) FROM games WHERE gamer_id = $USERNAME_ID")

  echo "Welcome back, $USERNAME! You have played $COUNT_GAMES games, and your best game took $BEST_TRY guesses."

else
  # insert into db
  INSERT_NEW_USER=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME')")
  # echo $INSERT_NEW_USER

  # Get the user id
  USERNAME_ID=$($PSQL "SELECT gamer_id FROM users WHERE name ILIKE '$USERNAME'")

  echo "Welcome, $USERNAME! It looks like this is your first time here."

fi


#######################
# SEARCH FOR THE NUM. #
#######################

RANDOM_NUMBER=$[$RANDOM % 1000 + 1]
ATTEMPTS=0
TRY=0

echo "Guess the secret number between 1 and 1000:"
while [[ $RANDOM_NUMBER -ne $TRY ]]
do
  read TRY
  let ATTEMPTS=ATTEMPTS+1

  # check if its a number
  if [[ $TRY =~ ^[0-9]+$  && $TRY -ne "" ]]
  then
    # let ATTEMPTS=ATTEMPTS+1

    #check the logic
    if [[ $TRY -gt $RANDOM_NUMBER ]]
    then
      echo "It's lower than that, guess again:"

    elif [[ $TRY -lt $RANDOM_NUMBER ]]
    then
      echo "It's higher than that, guess again:"

    else
      echo "You guessed it in $ATTEMPTS tries. The secret number was $RANDOM_NUMBER. Nice job!"
    fi

  else
    echo "That is not an integer, guess again:"
  fi
done


#######################
# SAVE THE DT INTO DB #
#######################

GAME_INSERTED=$($PSQL "INSERT INTO games VALUES($USERNAME_ID, $RANDOM_NUMBER, $ATTEMPTS)")
