#!/bin/bash

echo -e "\e[32mStart.\e[0m"

SVN_REPO_URL="svn+ssh://svn.srvdev.ru/spool/subversion/ktlo"

cd ~/

echo "Setting LC_TYPE evironment variable."
locale-gen ru_RU.UTF-8
LC_CTYPE=ru_RU.UTF-8
export LC_CTYPE

echo "Creating .subversion/ directory."
mkdir .subversion

echo "Creating subversion config file."
echo "[tunnels]" > .subversion/config
echo "ssh = ssh -v -l e.ilyushin -i $HOME/.ssh/id_rsa" >> .subversion/config

echo "Checkouting svn working copy."

chmod 600 $HOME/.ssh/id_rsa
svn co "$SVN_REPO_URL"

if [ -d "ktlo" ]; then
    echo -e "\e[32mWorking copy checkouted successfully.\e[0m"
else
    echo -e "\e[31mFailed to checkout svn working copy.\e[0m"
    exit 1
fi

echo "Creating temporary directories."
mkdir -p tmpdir/client
mkdir tmpdir/server

chmod -R 777 $HOME/webapps/

echo "Copying client sources."
cp -a ktlo/Client/. tmpdir/client/

if [ -d "$HOME/webapps/ROOT" ]; then
    rm -rf $HOME/webapps/ROOT
fi

if [ -f "$HOME/webapps/ROOT.war" ]; then
    rm $HOME/webapps/ROOT.war
fi

echo "Building client."
cd tmpdir/client/

npm install
npm run build

if [ -d "dist" ]; then
    echo -e "\e[32mClient built successfully.\e[0m"
else 
    echo -e "\e[31mFailed to build client.\e[0m"
    exit 1
fi

cd dist/

echo "Creating client .war file."
mv index.jsp index.jsp.h
echo -e "<%@ page contentType='text/html; charset=UTF-8' pageEncoding='UTF-8' %>" >> index.jsp
cat index.jsp.h >> index.jsp
rm -f index.jsp.h
zip -r ROOT.war .

if [ -f "ROOT.war" ]; then
    echo -e "\e[32mClient .war file created successfully.\e[0m"
else
    echo -e "\e[31mFailed to create client .war file.\e[0m"
    exit 1
fi

echo "Copying client .war to webapps/ directory"
\cp ROOT.war $HOME/webapps/

cd ~/

echo "Copying server sources."
cp ktlo/Server/pom.xml tmpdir/server/pom.xml
cp -R ktlo/Server/src tmpdir/server/src

echo "Setting application properties."
cat $HOME/properties/application.properties > tmpdir/server/src/main/resources/application.properties

if [ -d "$HOME/webapps/ServerLogic-0.0.1" ]; then
    rm -rf $HOME/webapps/ServerLogic-0.0.1
fi

if [ -f "$HOME/webapps/ServerLogic-0.0.1.war" ]; then
    rm $HOME/webapps/ServerLogic-0.0.1.war
fi

echo "Building server."
cd tmpdir/server/

mvn package

if [ -d "target" ]; then
    echo -e "\e[32mServer built successfully.\e[0m"
else
    echo -e "\e[31mFailed to build server.\e[0m"
    exit 1
fi

echo "Copying server .war file to webapps/"
\cp target/ServerLogic-0.0.1.war $HOME/webapps/

cd ~/

echo "Removing temporary directories."
rm -rf ktlo/
rm -rf tmpdir/

echo -e "\e[32mFinish.\e[0m"

