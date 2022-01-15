FROM ubuntu:20.04

# Résolution de 
#   E: Package 'gnupg' has no installation candidate
#   E: Package 'gnupg2' has no installation candidate
#   E: Package 'gnupg1' has no installation candidate
# Pendant apt-get install gnupg ...
RUN apt-get update
# Résolution de 
#   E: gnupg, gnupg2 and gnupg1 do not seem to be installed, but one of them is required for this operation
# Pendant apt-key adv ... 
RUN apt-get install -y gnupg gnupg2 gnupg1 
# RUN dpkg --configure -a
# RUN apt-get install apt-utils
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCD
# Résolution de 
#   bash: lsb_release: command not found
#   bash: add-apt-repository: command not found
# Pendant 
RUN echo "Y\n8\n37\n8\n" | apt-get install software-properties-common
RUN add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
RUN apt-get install -y librealsense2-dkms
RUN apt-get install -y librealsense2-utils
RUN apt-get install -y librealsense2-dev 
RUN apt-get install -y librealsense2-dbg