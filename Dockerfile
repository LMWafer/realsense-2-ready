FROM ubuntu:20.04

RUN apt-get update && \

    apt-get install apt-utils && \

    echo "Y\n8\n37" | apt-get install software-properties-common && \

    apt-get update && \

    apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCD && \

    add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u && \

    echo "Y\n" | apt-get install librealsense2-dkms && \

    echo "Y\n" | apt-get install librealsense2-utils && \

    apt-get install librealsense2-dev && \

    apt-get install librealsense2-dbg