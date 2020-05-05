#!/bin/bash
PORT=8080
SETTING_FILE=/work/port-override.txt

if test -f "$SETTING_FILE"; then
    PORT=`cat ${SETTING_FILE}`
    echo "Configuring custom port setting to " $PORT
    /bin/sed -i "s#http://127.0.0.1:8080/#http://127.0.0.1:${PORT}/#" /www/ict2/js/ict2.js
    /bin/sed -i "s#http://127.0.0.1:8080/#http://127.0.0.1:${PORT}/#g" /www/index.html
    # Tidy up:
    /bin/rm $SETTING_FILE
fi

/usr/bin/spawn-fcgi -f /fcgi-bin/iipsrv.fcgi -a 127.0.0.1 -p 9000
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf &
echo "Citable image service booted and running."
