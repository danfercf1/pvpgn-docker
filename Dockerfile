FROM quay.io/danfercf/ubuntu-dev:0.1
MAINTAINER danfercf@gmail.com
RUN mkdir -p /usr/src/pvpgn
WORKDIR /usr/src/
ADD pvpgn/. /usr/src/pvpgn/
WORKDIR /usr/src/pvpgn/ 
RUN cmake -D CMAKE_INSTALL_PREFIX=/usr/local/pvpgn -D WITH_MYSQL=true -D WITH_LUA=true ./ && make && make install
WORKDIR /
ADD files/. usr/local/pvpgn/var/files/
COPY bnetd.conf usr/local/pvpgn/etc/
COPY channel.conf usr/local/pvpgn/etc/
EXPOSE 6112
RUN mkdir -p /var/log/pvpgn/
RUN mkdir -p usr/local/pvpgn/maps
CMD /usr/local/pvpgn/sbin/bnetd && tail -f /dev/null
