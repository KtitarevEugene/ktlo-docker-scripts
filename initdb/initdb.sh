#!/bin/bash

SOURCES="/usr/local/src/pg-initdb"

if [[ "$(which psql 2> /dev/null)" == "" ]]; then
    echo -e "\e[31mpostgresql-client isn't installed.\e[0m"
    exit 1
fi

echo "Target host: '$HOST:$PORT'"
echo "Target database name: '$DB'"

chmod 600 $HOME/.pgpass

locale-gen $LOCALE
update-locale

echo "Initializing database."
for FILE in $(find $SOURCES -name "*.sql")
do
    echo "Found script: $FILE"
    psql -h $HOST -p $PORT -U $USER -f $FILE -d $DB
done
echo "Done."
