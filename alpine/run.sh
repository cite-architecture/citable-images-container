#
# start a bash shell in the docker container here.

docker run -p 8080:80 --rm -it -v $(pwd):/work ${IMAGE_NAME}:latest  /bin/bash
