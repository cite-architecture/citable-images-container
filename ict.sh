#!/bin/bash

PORT=8080
MOUNTS=

for arg in "$@"
do
  case $arg in
    -p|--port)
    PORT=$2
    echo PORT setting $PORT
    shift
    shift
    ;;

    *)
    echo ARG: "# $1 #"
    if echo "$1" | grep -q '/$'; then
      echo "Trailing slash in " $1
      MOUNTS+=" -v $1:/pyramids"
      echo $MOUNTS
    elif [[ $1 == " " ]]; then
      shift
    else
      echo "No trailing slash: explode #" $1 "#"
      oldIFS=$IFS
      IFS="/"
      read -ra PATHPARTS <<<"$1"
      echo "COMPONENTS: " ${#PATHPARTS[@]}
      if [[ ${#PATHPARTS[@]} -gt 0 ]]; then
        SIZE=${#PATHPARTS[@]}
        let "LASTELEMENT=$SIZE-1"
        echo "LAST COMPONENT " $LASTELEMENT " FROM SIZE " $SIZE
        echo "LAST COMPON VAL " ${PATHPARTS[$LASTELEMENT]}
        PYRAMID_DIR="/pyramids/${PATHPARTS[$LASTELEMENT]}"
        #MOUNTS+=" -v $1:pyramids/${PATHPARTS[$LASTELEMENT]}"
        echo MOUNT ${1} " in " $PYRAMID_DIR
        #echo $MOUNTS
      fi
      #echo ${PATHPARTS[${#PATHPARTS[@]}-1]}
      IFS="$oldIFS"
      #for i in "${PATHPARTS[@]}"; do # access each element of array
      #MOUNTS+=" -v $1:pyramids/${PATHPARTS[-1]}"
      #echo "$MOUNTS"
      #done
    fi
    shift
    ;;
  esac

done

#docker run -p 8080:80 --rm -it -v $(pwd):/work ${IMAGE_NAME}:latest  /bin/bash
