spawn-fcgi -f /fcgi-bin/iipsrv.fcgi -a 127.0.0.1 -p 9000
lighttpd -D -f /etc/lighttpd/lighttpd.conf &
echo "Citable image service booted and running."
