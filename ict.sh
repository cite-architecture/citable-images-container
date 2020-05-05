#!/bin/bash
#
# ict.sh version 1.0.0
#
# Start a docker container with a citable image service.
# See:
#    https://github.com/cite-architecture/citable-images-container
#
# Mounts local working directory as /work in the container.
# Supports optionally setting values for port on the host OS,
# and directories of citable images to mount in the container.
#
# Usage:
#
#    ict.sh [-p|--port PORT_NUMBER] [/PATH/TO/IMAGE/ROOT/] [/PATH/TO/NAMESPACE_1 /PATH/TO/NAMESPACE_2... /PATH/TO/NAMESPACE_N]
#
#
# Default values for two settings we will optionally
# modify from command-line arguments: port 8080,
# no file systems to mount.
PORT=8080
MOUNTS=

# Convenience function to glue bash array together
function join_by { local IFS="$1"; shift; echo "$*"; }

for arg in "$@"
do
  case $arg in
    -p|--port)
    # Override default PORT setting:
    PORT=$2
    shift
    shift
    ;;

    *)
    if echo "$1" | grep -q '/$'; then
      #Trailing slash: mount as root of service:
      MOUNTS+=" -v $1:/pyramids/"
      echo $MOUNTS
    elif [[ $1 == " " ]]; then
      shift
    else
      # No trailing slash: mount as namespace
      oldIFS=$IFS
      IFS=/
      read -ra PATHPARTS <<<"$1"
      if [[ ${#PATHPARTS[@]} -gt 0 ]]; then
        SIZE=${#PATHPARTS[@]}
        let "LASTELEMENT=$SIZE-1"
        DIR=${PATHPARTS[LASTELEMENT]}
        IFS=$oldIFS
        SLASHED=/`join_by / ${PATHPARTS[@]}`:/pyramids/${DIR}
        MOUNTS+=" -v ${SLASHED}"
        echo $MOUNTS
      else
        IFS=$oldIFS
      fi
    fi
    shift
    ;;
  esac
done

# Record port in a temp file that serve.sh script in the docker container
# can find:
echo $PORT > port-override.txt

# Run container using settings from command-line arguments:
docker run -p ${PORT}:80 --rm -it -v $(pwd):/work ${MOUNTS} neelsmith/ict:latest  /bin/bash
