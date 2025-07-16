FROM debian:bullseye-slim

ENV MDB_USER=$

RUN apt-get update && \
	apt-get upgrade && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3306

ENTRYPOINT ["./conf/init.sh"]