FROM ubuntu:focal

# install and configure tzdata
RUN apt-get -y update
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# install remaining dependencies
RUN apt-get -y install cmake
RUN apt-get -y install clang
RUN apt-get -y install libclang-dev
RUN apt-get -y install make
RUN apt-get -y install gcc
RUN apt-get -y install g++
RUN apt-get -y install libc-dev
RUN apt-get -y install libboost-all-dev
RUN apt-get -y install wget
RUN apt-get -y install git

# install rpi tools for arm compiler
RUN git clone https://github.com/raspberrypi/tools /raspberry_pi/tools
ENV PATH="$PATH:/raspberry_pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/"

# compile boost
WORKDIR /boost_rpi
RUN wget -q https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.bz2
RUN tar --bzip2 -xf boost_1_72_0.tar.bz2
WORKDIR /boost_rpi/boost_1_72_0
RUN ./bootstrap.sh --prefix=/boost_rpi
RUN echo "using gcc : arm : arm-linux-gnueabihf-g++ ;" >> project-config.jam
RUN ./b2 --prefix=/boost_rpi --with-system --with-thread --with-date_time --with-regex --with-serialization toolset=gcc-arm link=static install
