CWD=$(dirname "$0")

. "$CWD/helpers/log.sh"

function dotenv {
    envfile=$1

    if [ -f "$envfile" ]
    then
      export $(cat "$envfile" | xargs)
    else
      error "Coudln't load .env file"
    fi
}
