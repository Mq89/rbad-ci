FROM ubuntu:focal

RUN apt-get -y update
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

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
