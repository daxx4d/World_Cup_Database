#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

while IFS=",", read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  if [[ $YEAR == "year" ]]; then
     continue
  fi

	#year
  #echo $($PSQL "INSERT INTO games(year) VALUES($YEAR)")

  #round
  #echo $($PSQL "INSERT INTO games(round) VALUES($ROUND)")

  #winner
  if [[ $($PSQL "SELECT name FROM teams WHERE name='$WINNER'") == "" ]]
  then
    echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
  fi
    
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  #echo $($PSQL "INSERT INTO games(winner_id) VALUES($WINNER_ID)")

  #opponent
  if [[ $($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'") == "" ]]
  then
    echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
  fi
    
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  #echo $($PSQL "INSERT INTO games(opponent_id) VALUES($OPPONENT_ID)")

  #winner goals
  #echo $($PSQL "INSERT INTO games(winner_goals) VALUES($WINNER_GOALS)")

  #opponent goals
  #echo $($PSQL "INSERT INTO games(opponent_goals) VALUES($OPPONENT_GOALS)")

  echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

done < games.csv
