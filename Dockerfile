FROM ioft/armhf-ubuntu:16.10
EXPOSE 6112
MAINTAINER danfercf@gmail.com
RUN apt-get update && apt-get install -y build-essential libboost-all-dev libbz2-dev libmysqlclient-dev libgmp3-dev liblua5.1-0-dev git cmake
RUN mkdir -p /usr/src/pvpgn
WORKDIR /usr/src/
#RUN git clone https://github.com/danfercf1/pvpgn-server.git pvpgn
ADD pvpgn/. /usr/src/pvpgn/
WORKDIR /usr/src/pvpgn/ 
RUN cmake -D CMAKE_INSTALL_PREFIX=/usr/local/pvpgn -D WITH_MYSQL=true -D WITH_LUA=true ./ && make && make install
WORKDIR /
ADD files/. usr/local/pvpgn/var/files/
COPY bnetd.conf usr/local/pvpgn/etc/
COPY channel.conf usr/local/pvpgn/etc/
CMD /usr/local/pvpgn/sbin/bnetd && tail -f /dev/null
