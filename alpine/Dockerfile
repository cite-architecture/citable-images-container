FROM alpine:latest

RUN apk --update add wget curl tar bash make g++ readline-dev ncurses-dev git git-bash-completion ncurses gzip tiff tiff-dev libjpeg-turbo libjpeg-turbo-dev lighttpd spawn-fcgi
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

COPY iipsrv-1.1.tar.bz2 /iipsrv-1.1.tar.bz2
RUN tar -xf iipsrv-1.1.tar.bz2 && cd iipsrv-1.1 && ./configure && make
RUN mkdir /fcgi-bin && cp /iipsrv-1.1/src/iipsrv.fcgi /fcgi-bin

COPY serve.sh /serve.sh
RUN echo && echo "Downloading demo image..." && echo
RUN curl http://www.homermultitext.org/VA012RN_0013.tif > /VA012RN_0013.tif
