#!/bin/bash
#
# Start

PORT=8080
MOUNTS=

function join_by { local IFS="$1"; shift; echo "$*"; }

for arg in "$@"
do
  case $arg in
    -p|--port)
    PORT=$2
    #echo PORT setting $PORT
    shift
    shift
    ;;

    *)
    #echo ARG: "# $1 #"
    if echo "$1" | grep -q '/$'; then
      #echo "Trailing slash in " $1
      MOUNTS+=" -v $1:/pyramids/"
      echo $MOUNTS
    elif [[ $1 == " " ]]; then
      shift
    else
      #echo "No trailing slash: explode #" $1 "#"
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

docker run -p ${PORT}:80 --rm -it -v $(pwd):/work ${MOUNTS} neelsmith/ict:latest  /bin/bash
