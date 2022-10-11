#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo "$($PSQL "TRUNCATE TABLE games, teams")"


##############################
########### TEAMS ############
##############################
echo ------ TEAMS ------

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
  if [[ $YEAR != 'year' ]]
  then

    # Extract the winner from teams
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER' ")

    if [[ -z $TEAM_ID ]] 
    then 
      INSERT_WINNER_TEAMS="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
      # echo $INSERT_WINNER_TEAMS
      if [[ $INSERT_WINNER_TEAMS = 'INSERT 0 1' ]]
      then
        echo Inserted into teams from winner
      fi
    fi

    # Extract the opponent from teams
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT' ")

    if [[ -z $TEAM_ID ]] 
    then 
      #echo No values
      INSERT_OPPONENT_TEAMS="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
      # echo $INSERT_OPPONENT_TEAMS
      if [[ $INSERT_OPPONENT_TEAMS = 'INSERT 0 1' ]]
      then
        echo Inserted into teams from opponent
      fi
    fi
  fi
done



##############################
########### GAMES ############
##############################
echo ------ GAMES ------

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
  if [[ $YEAR != 'year' ]]
  then

    WINNER_TEAMS_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    OPPONENT_TEAMS_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")

    INSERT_GAME_LINE=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_TEAMS_ID, $OPPONENT_TEAMS_ID, $W_GOALS, $O_GOALS)")
    if [[ $INSERT_GAME_LINE = 'INSERT 0 1' ]]
    then
      echo Inserted into games succesfully
    fi
  fi
done
