echo "Setting up directories for demo image..."
mkdir -p /work/pyramids/hmt/vaimg/2017a
cp /VA012RN_0013.tif /work/pyramids/hmt/vaimg/2017a
spawn-fcgi -f /fcgi-bin/iipsrv.fcgi -a 127.0.0.1 -p 9000
lighttpd -D -f /etc/lighttpd/lighttpd.conf &
echo "Citable image service booted and running."
echo "It has one demo image with URN urn:cite2:hmt:vaimg.2017a:VA012RN_0013"
