# A docker container for a citable image service



Docker file and scripts are in `alpine`.


Goals for container:


- √ iipsrv. (Built from archived source of version 1.1, since source download from sourceforge is so kludgy.  Better to download a specific version from git.)
- √ a web server:
    - √ configure fastcgi to be accessible through web server
    - √ map container ports to local port and a local data directory to a mount point in the container
