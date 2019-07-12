FROM ubuntu

ADD initdb.sh /usr/local/bin/initdb.sh

RUN apt-get update --yes && \
    apt-get install --yes postgresql-client && \
    apt-get install --yes locales

VOLUME ["/usr/local/src/pg-initdb"]
VOLUME ["/root"] 

CMD ["/bin/bash", "initdb.sh"]

