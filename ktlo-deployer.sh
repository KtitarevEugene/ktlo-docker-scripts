#!/bin/bash

check_image_existence () {

    if [[ "$(docker images -q "$1" 2> /dev/null)" == "" ]]; then

        echo -e "\e[33m'$1' image doesn't exist. Checking 'Dockerfile'.\e[0m"
        if [ -f "$2/Dockerfile" ]; then
            echo -e "\e[33mFound 'Dockerfile' for '$1' image. Attempt to build up.\e[0m"

            docker build -t "$1:latest" "$2/"

            if [[ "$(docker images -q "$1" 2> /dev/null)" == "" ]]; then
                echo -e "\e[31mFailed to build '$1' image.\e[0m"
                return 1
            else
                echo -e "\e[32m'$1' built successfully.\e[0m"
                return 0
            fi

        else

            echo -e "\e[31m'Dockerfile' for '$1' doesn't exist.\e[0m"
            return 1
        fi
    else
        echo "Stop and remove running container '$1'."
        
        docker stop "$3"
        docker rm "$3"
        
        return 0
    fi
}

if [[ "$(docker images -q postgres 2> /dev/null)" == "" ]]; then
    
    echo -e "\e[33mDocker image 'postgres' not found. Attempt to download.\e[0m"
    
    docker pull postgres
    
    if [[ "$(docker images -q postgres 2> /dev/null)" == "" ]]; then
        echo -e "\e[31mFailed to download 'postgres'.\e[0m"
        exit 1
    else
        echo -e "\e[32mImage 'postgres' downloaded successfully.\e[0m"
    fi
else
    echo "Stop and remove running container 'ktlo-pg'."
    
    docker stop ktlo-pg 
    docker rm ktlo-pg
fi

CURRENT_DIR="$(pwd)"
HOME="/root"

PGDATA="/var/lib/postgresql/data"
PGSERVER=$(cat "$CURRENT_DIR/shared/.pgpass" | awk -F':' '{ print $1 }')
PGPORT=$(cat "$CURRENT_DIR/shared/.pgpass" | awk -F':' '{ print $2 }')
PGUSER=$(cat "$CURRENT_DIR/shared/.pgpass" | awk -F':' '{ print $4 }')
PGDB=$(cat "$CURRENT_DIR/shared/.pgpass" | awk -F':' '{ print $3 }')

if [ -d "$CURRENT_DIR/ktlo-data" ]; then
    chmod -R 777 "$CURRENT_DIR/ktlo-data"
    rm -rf "$CURRENT_DIR/ktlo-data"
fi

mkdir "$CURRENT_DIR/ktlo-data"

echo "Start 'ktlo-pg' container."
docker run -d --rm \
    --name ktlo-pg \
    -e PGPASSWORD="$(cat "$CURRENT_DIR/shared/.pgpass" | awk -F':' '{ print $5 }')" \
    -v "$CURRENT_DIR/ktlo-data:$PGDATA" \
    -p "$PGPORT:5432" \
    postgres

check_image_existence "ktlo-initdb" "initdb" "initdb"

if [[ $? -eq 1 ]]; then
    exit $?
fi

echo "Start initializing database."
docker run \
    --name initdb \
    -e HOST="$PGSERVER" \
    -e PORT="$PGPORT" \
    -e DB="$PGDB" \
    -e USER="$PGUSER" \
    -e LOCALE="en_US.utf8" \
    -v "$CURRENT_DIR/shared:$HOME" \
    -v "$CURRENT_DIR/shared:/usr/local/src/pg-initdb" \
    ktlo-initdb


check_image_existence "ktlo-builder" "builder" "builder"

if [[ $? -eq 1 ]]; then
    exit $?
fi

check_image_existence "ktlo-deployer" "deployer" "deployer"

if [[ $? -eq 1 ]]; then
    exit $?
fi

CATALINA_HOME="/usr/local/tomcat"

echo "Start 'ktlo-builder' container."
docker run \
    --name builder \
    -v "$CURRENT_DIR/shared:$HOME/.ssh" \
    -v "$CURRENT_DIR/shared:$HOME/properties" \
    -v "$CURRENT_DIR/shared/webapps:$HOME/webapps" \
    ktlo-builder

if [ -f "$CURRENT_DIR/shared/webapps/ROOT.war" ] && [ -f "$CURRENT_DIR/shared/webapps/ServerLogic-0.0.1.war" ]; then
    echo -e "\e[32m'ROOT.war' and 'ServerLogic-0.0.1.war' saved to $CURRENT_DIR/shared/webapps\e[0m"
else
    echo -e "\e[31m'ROOT.war' and/or 'ServerLogic-0.0.1.war' don't exist.\e[0m"
    echo -e "\e[31mScroll logs up to figure out what went wrong.\e[0m"
    exit 1
fi

echo "Start 'ktlo-deployer' container."
docker run -d \
    --name deployer \
    -v "$CURRENT_DIR/shared/webapps:$CATALINA_HOME/webapps" \
    -p 8080:8080 \
    ktlo-deployer

docker rmi $(docker images -f dangling=true -q)

