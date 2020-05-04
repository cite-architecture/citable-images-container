# A docker container for a citable image service




## Usage

To start a container: **SCRIPTS AND GIST TBA HERE**.

Within a running docker container,

```sh
/serve.sh
```

starts IIPSRV and lighttpd.

## Configuration

-  IIPSRV fast cgi binary is in `/fcgi-bin/iipsrv.fcgi` running on port 9000 when started from `serve.sh`
- `lighttpd` runs on port 80 in the docker container
    - configuration file is in `/etc/lighttpd/lighttpd.conf`
    - web root is in `/www`
    - logs are in `/var/log/lighttpd`
    - IIPSRV is available as `http://127.0.0.1/fcgi-bin/iipsrv.fcgi`


## Building the container

Docker file and source files for building image are in `alpine`.  See the README in that directory.
