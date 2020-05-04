# A docker container for a citable image service


## Overview: TBA

Serve your own collections of canonically citable images.  For a working example of the image citation tool, see <http://www.homermultitext.org/ict2/>.

A few highlights while waiting for documentation...


- pannable/zoomable images are served using [IIPImage Server](https://iipimage.sourceforge.io/documentation/server/), and are accessible via IIIF protocol
- you can serve your own images using a convenience script (below) or manually mounting a properly laid out directory at `/pyramids` in the container
- you can add your own web pages to the web server

### Adding your own images

Pyramidal (tiled) images are served from the `/pyramids` directory.  Within this directory, images should be organized in subdirectories mirroring their URN.  For an image identified as `urn:cite2:namespace:group.version:IMAGE1`, the directory structure should be `/pyramids/namespace/group/version`.  The base name of image should be `IMAGE1` with appropriate extension for the its file type.  If `IMAGE1` is a pyramidal TIFF file, then the full path of the image on the server will be `/pyramids/namespace/group/version/IMAGE1.tif`, for example


## Usage


### Start a container

- **CONVENIENCE SCRIPTS AND GIST TBA HERE**

This inconvenient massive command-line example will start a bash shell in the container, make the container's service available on port 8080 of the host operating system, and make the current directory available in the container mounted at `/work`.

```sh
docker run -p 8080:80 --rm -it -v $(pwd):/work neelsmith/ict:latest  /bin/bash
```


### Start the service

Within a running docker container,

```sh
/serve.sh
```

starts IIPSRV and lighttpd.

## Technical documentation: configuration of the docker image

-  IIPSRV fast cgi binary is in `/fcgi-bin/iipsrv.fcgi` running on port 9000 when started from `serve.sh`
    - the root directory of the citable service is configured in `/pyramids`
- `lighttpd` runs on port 80 in the docker container
    - configuration file is in `/etc/lighttpd/lighttpd.conf`
    - web root is in `/www`
    - logs are in `/var/log/lighttpd`
    - IIPSRV is available as `http://127.0.0.1/fcgi-bin/iipsrv.fcgi`

## Using IIIF with the service

TBA

## Building the container

Docker file and source files for building image are in `alpine`.  See the README in that directory.
