#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != 'year' || $ROUND != 'round' || $WINNER != 'winner' || $OPPONENT != 'opponent' || $WINNER_GOALS != 'winner_goals' || $OPPONENT_GOALS != 'opponent_goals' ]]
  then
    WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
    OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"
    if [[ !$TEAM_ID ]]
      then
        RESULT="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
        if [[ $RESULT == "INSERT 0 1" ]]
          then
            echo "Successfully inserted into teams, $WINNER"
        fi
    fi
    if [[ !$OPPONENT_ID ]]
      then
        RESULT="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
        if [[ $RESULT == "INSERT 0 1" ]]
          then
            echo "Successfully inserted into teams, $OPPONENT"
        fi
    fi
  fi
done

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != 'year' || $ROUND != 'round' || $WINNER != 'winner' || $OPPONENT != 'opponent' || $WINNER_GOALS != 'winner_goals' || $OPPONENT_GOALS != 'opponent_goals' ]]
    then
      WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
      OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"

      RESULT="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"

      if [[ $RESULT == "INSERT 0 1" ]]
        then
          echo "Successfully inserted into games"

      fi
  fi
done

# Do not change code above this line. Use the PSQL variable above to query your database.
