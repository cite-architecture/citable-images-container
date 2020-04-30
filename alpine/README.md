


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
