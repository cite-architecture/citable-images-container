# A docker container for a citable image service



A docker container to serve your own collections of canonically citable images.  The container includes [IIPImage Server](https://iipimage.sourceforge.io/documentation/server/) and a web server with this [image citation tool](https://github.com/cite-architecture/ict2) for identifying regions with CITE2 URNs.

The service is mapped to a specified port (default: 8080) on your host computer. You can use the image citation service by opening a browser on `http://127.0.0.1:8080/` (or whatever port you chose).  The IIPImage service also  implements the IIIF protocol.

### Try the citation tool

For a working example of the image citation tool, see <http://www.homermultitext.org/ict2/>, or try a demo on your computer:


```sh
docker run -p 8080:80 --rm -it  neelsmith/ict:latest  /bin/bash
```

Then in the container's bash shell:

```sh
/demo.sh
```

## Organizing your images

Images should be organized in subdirectories mirroring the namespace, group and version elemetns of their URN.  For example, for an image identified as `urn:cite2:namespace:group.version:IMAGE1`, the directory structure should be `/PATH/TO/IMAGES/namespace/group/version`.  The base name of image should be `IMAGE1` with appropriate extension for the its file type.  If `IMAGE1` is a pyramidal TIFF file, then the full path of the image on the server will be `/PATH/TO/IMAGES/namespace/group/version/IMAGE1.tif`.



In the docker container, pyramidal (tiled) images are served from the `/pyramids` directory.  You can use manually add images in the docker environment, or use the bash script described in the following section to mount directories in your host file system in the docker container.


## Usage

The container is designed so that you can use the image service in two steps:

1.  Start the docker with an interactive bash shell.
2.  In the container, start the image service.


### 1. Start a container


#### Use a convenience script

To include your own directories automatically when you start the docker container, you can use [this bash script](https://github.com/cite-architecture/citable-images-container/blob/master/ict.sh).

The script works as follows:

```sh
 ict.sh [-p|--port PORT_NUMBER] [/PATH/TO/IMAGE/ROOT/] [/PATH/TO/NAMESPACE_1 /PATH/TO/NAMESPACE_2... /PATH/TO/NAMESPACE_N]
```

With no arguments, it starts the docker container.  No images will be mounted.  


Options:


- `-p` or `--port` Set the port number where the service should appear on your local machine
- `/PATH/TO/IMAGE/ROOT/` A full path with trailing slash is treated as the root directory for your image collection.  Its subdirectories should be namespace-level directories of images.
- `/PATH/TO/NAMESPACE` A path *without* trailing slash is treated as a namespace-level directory.

(The difference between presence or absence of trailing slash mimics the usage of `rsync`.)

#### Examples


Note that for a single hierarchical file system of pyramidal images, the following two commands are identical

```sh
ict.sh /pyramids/
```

and

```sh
ict.sh /pyramids/*
```

On the other hand, if you have pyramidal image collections in multiple locations in your file system, you can serve all of them with a command like this:

```
icts.sh /volume1/pyramids/* /volume2/pyramids/*
```



Alternatively, you can manually start the docker container with command-line parameters to map image directories if you prefer.  The root of the image file hierarchy in the container is `/pyramids`, so this  example starts a bash shell in the container, makes the container's service available on port 8000 of the host operating system, makes the current directory available in the container mounted at `/work`, and uses the directory `/myimages` as the root of the image service mounted in the container at `/pyramids`.

```sh
docker run -p 8000:80 --rm -it -v $(pwd):/work -v /myimages:/pyramids neelsmith/ict:latest  /bin/bash
```


### 2. Start the service

Within a running docker container,

```sh
/serve.sh
```

starts IIPImage server and lighttpd.

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
