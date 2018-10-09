#!/bin/sh

docker run --name visimeet --rm --net host --privileged=true --ipc=host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/passwd:/etc/passwd:ro --user=$(id -u) \
  -v ${HOME}:${HOME} -w ${HOME}  -e DISPLAY=unix$DISPLAY \
  -e HOME=${HOME} \
  -v /dev:/dev --device /dev/snd \
    -v /etc/machine-id:/etc/machine-id \
    -v /run/user/$(id -u):/run/user/$(id -u) \
    -v /var/lib/dbus:/var/lib/dbus \
  -ti visimeet_img /opt/visimeet/visimeet.sh
  