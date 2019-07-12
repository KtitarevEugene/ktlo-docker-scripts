FROM ubuntu

ENV HOME /root

ADD build.sh /usr/local/bin/build.sh 

RUN apt-get update --yes && \
    apt-get install --yes subversion && \
    apt-get install --yes openssh-client

RUN apt-get install --yes locales && \
    apt-get install --yes maven
    
RUN apt-get install --yes sudo && \
    apt-get install --yes curl gnupg
    
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash
    
RUN apt-get install --yes nodejs && \
    apt-get install --yes zip unzip

VOLUME ["$HOME/.ssh"]
VOLUME ["$HOME/properties"]
VOLUME ["$HOME/webapps"]

ENTRYPOINT ["/bin/bash"]
CMD ["/usr/local/bin/build.sh"]

#RUN mkdir ~/.ssh && \
#    echo ${key_prv} | tr "," "\n" > ~/.ssh/id_rsa && \
#    ssh-keyscan svn.srvdev.ru > ~/.ssh/known_hosts && \
#    chmod 600 ~/.ssh/id_rsa && \
#    chmod 700 ~/.ssh

#FROM tomcat 

#VOLUME ["$CATALINA_HOME/webapps"]

#COPY --from=MAVEN /tmpdir/server/target/ServerLogic-0.0.1.war $CATALINA_HOME/webapps/ServerLogic-0.0.1.war
#COPY --from=MAVEN /tmpdir/client/dist/ROOT.war $CATALINA_HOME/webapps/ROOT.war

#HEALTHCHECK --interval=1m --timeout=3s CMD wget --quiet --tries=1 --spider http://localhost:8080/wizard/ || exit 1

#EXPOSE 8080

#ENTRYPOINT ["catalina.sh"]
#CMD ["run"]

