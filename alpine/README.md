
## Sources

- The `iipsrv-1.1` directory mirrors the source code for version 1.1 of IIPImage, available under the GPL-3 license from <https://github.com/ruven/iipsrv>.
- The demo image included when this container is built is (c) 2010, Center for Hellenic Studies and licensed under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. The CHS/Marciana Imaging Project was directed by David Jacobs of the British Library.




## Build and publish


From within the `docker` directory,

```sh
source envvars.sh
```

### Build

```sh
docker build -t ${IMAGE_NAME}:latest .
```

### Use or test a locally built image


```sh
./run.sh
```

### Publish a tested version


```sh
docker login #  if you haven't already
./publish.sh
```
