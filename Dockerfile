# Pull base image.
FROM ubuntu:16.04

MAINTAINER "Gayathri Mahalingam"

RUN adduser --quiet --disabled-password qtuser

# Install
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential pkg-config && \
  apt-get install -y software-properties-common cmake && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y yasm pkg-config libswscale-dev libtbb2 && \
  apt-get install -y libtbb-dev libpng-dev libtiff-dev libjasper-dev libavformat-dev libpq-dev && \
  apt-get install -y python python-dev python-distribute python-pip python-qt4 && \
  apt-get install -y python3 python3-dev python3-pip pyqt4-dev-tools && \
  apt-get install -y libspatialindex-dev gcc g++ gfortran cython pyqt5-dev-tools && \
  apt-get install -y libxml2-dev libxmlsec1-dev && \
  rm -rf /var/lib/apt/lists/*
  

# Set environment variables.
ENV HOME /app

# Define working directory.
WORKDIR /app

# pip install packages
RUN pip3 install numpy \
                opencv-contrib-python \
                scikit-image \
                lxml \
                resources \
                requests

WORKDIR /app/labelImg

COPY . /app/labelImg

RUN echo "alias python=python3" >> ~/.bash_aliases

RUN echo "alias pip=pip3" >> ~/.bash_aliases

RUN python3 setup.py install

# Define default command.
CMD ["bash"]