FROM openjdk:8-alpine

RUN apk --update add wget curl tar bash make g++ readline-dev ncurses-dev git git-bash-completion ncurses gzip tiff tiff-dev libjpeg-turbo libjpeg-turbo-dev lighttpd spawn-fcgi

COPY iipsrv-1.1.tar.bz2 /iipsrv-1.1.tar.bz2
RUN tar -xf iipsrv-1.1.tar.bz2 && cd iipsrv-1.1 && ./configure && make
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

RUN mkdir /fcgi-bin && cp /iipsrv-1.1/src/iipsrv.fcgi /fcgi-bin
