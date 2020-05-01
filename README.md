# A docker container for a citable image service



Docker file and scripts are in `alpine`.


Goals for container:


- √ iipsrv. (Built from archived source of version 1.1, since source download from sourceforge is so kludgy.)
- a web server (lighttpd?)
- map container ports to local port and a local data directory to a mount point in the container
- vips (convenient for making pyramidal tiffs)
