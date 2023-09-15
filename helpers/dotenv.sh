function dotenv {
    envfile=$1

    if [ ! -f "$envfile" ]
    then
      export $(cat "$envfile" | xargs)
    fi
}
