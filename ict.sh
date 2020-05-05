#!/bin/bash
#
# Start a docker container with citable image service,
# optionally setting values for port on the host OS,
# and directories to mount in the container.
#
# Usage:
#
#    ict.sh [-p|--port PORT_NUMBER] [/PATH/TO/IMAGE/ROOT/] [/PATH/TO/NAMESPACE1 /PATH/TO/NAMESPACE2... /PATH/TO/NAMESPACEN]
#

# Default values for two settings we will optionally
# modify from command-line arguments:
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
      #Trailing slash in: mount as root of service:
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

# Run container with settings from command-line arguments:
docker run -p ${PORT}:80 --rm -it -v $(pwd):/work ${MOUNTS} neelsmith/ict:latest  /bin/bash
