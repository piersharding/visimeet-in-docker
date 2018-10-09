FROM ubuntu:14.04

MAINTAINER Piers Harding "piers@ompka.net"

ENV LANG en_NZ.UTF-8
ENV LANGUAGE en_NZ.UTF-8
ENV LC_ALL en_NZ.UTF-8
ENV HOME /root

ENV DEBIAN_FRONTEND noninteractive

RUN \
    echo "Setting locales  ..." && \
    apt-get update && \
    apt-get install locales tzdata -y  && \
    /usr/sbin/locale-gen en_US.UTF-8 && \
    /usr/sbin/locale-gen en_NZ.UTF-8 && \
    echo "Setting timezone ..." &&  /bin/echo 'Pacific/Auckland' | tee /etc/timezone && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get upgrade -y && \
    apt-get install -y curl  libssl1.0.0 libxss1 wget && \
    apt-get clean -y

RUN \
    `# Install Visimeet dependencies` && \
    apt-get install libqt5webkit5 libqt5sensors5 libqt5multimedia5 \
    libqt5multimediawidgets5 libqt5xml5 libqt5xmlpatterns5 libavutil52 -y && \
    apt-get install xdg-utils -y && \
    apt-get install libqt5positioning5 libasound2 libgomp1 -y && \
    apt-get install   mplayer -y && \
    apt-get clean -y

RUN \
    cd /tmp && \
    wget http://download.iocom.com/client/visimeet_qt_16.10.28.1.x86_64.deb && \
    dpkg -i /tmp/visimeet_qt_16.10.28.1.x86_64.deb && \
    rm -f /tmp/visimeet_qt_16.10.28.1.x86_64.deb

# default command
CMD ["/opt/visimeet/visimeet.sh"]
