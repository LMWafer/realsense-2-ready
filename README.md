[**Introduction**](#introduction) | [**I want examples now !**](#i-want-examples-now) | [**General info**](#general-info) | [**Prerequisites**](#image-prerequisites) | [**Installation**](#image-installation) | [**How-tos**](#image-usage)

# Introduction 

## Reference

**Intel Realsense SDK**. **[Website](https://www.intel.fr/content/www/fr/fr/architecture-and-technology/realsense-overview.html)**. **[Github](https://github.com/IntelRealSense/librealsense)**. 

## What's that repo?

Just a Docker image that makes you skip the whole Intel Realsense SDK 2.0 installation process. Simply run a container and start *rs-* examples. No additional applications, no fancy dependencies... just the source code!
Moreover, all the images and their build are tested on 3 different machines with Ubuntu 20.04 to ensure they work properly!

Solved common issues (the real bois will know) : 
- *Could not open OpenGL window, please check your graphic drivers or use the textual SDK tools* when using **rs-capture**, **rs-multicam** like commands ;
- All the *gnupg* stuff (*package 'gpupgX' has no installation candidate* and *gnupgX does not seems to be installed* etc.)
- *lsb_release: command not found* and *add-apt-repository: command not found*

This repository contains release info and advanced image manipulation. See the project's **[Dockerhub](https://hub.docker.com/r/lmwafer/realsense-ready)** tags info.

# I want examples now
1. Make sure to have the basic docker dependencies mentioned [here](#image-prerequisites). 
  
2. This will pull the image from [Dockerhub](https://hub.docker.com/r/lmwafer/realsense-ready/tags) and run a container (needs a GPU for Pangolin, container removed after exit)
```bash
sudo xhost +local:root && docker run --privileged --name realsense-2-container --rm -p 8084:8084 -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev:/dev:ro --gpus all -it lmwafer/realsense-ready:2.0-ubuntu18.04
```

3. Run this inside the container to start a real time demo (with Intel D435i plugged in)
```bash
rs-multicam
```
You can run every example that comes along the SDK. Everything in the image is already built!

# General info
The image is based on a [Ubuntu 18.04](https://hub.docker.com/_/ubuntu?tab=tags&page=1&name=18.04) layer. 

The images tag follows this template : `<image version>-<os name><os version>`. 
`<os name>` is the name of the **Docker os** not the system one, same thing for `<os version>`. `<image version>` is specific to `<os name><os version>`. That means image version refers to the work advancement for the Docker version.

Every dependency is installed in */dpds* directory. Reach realsense directory with 
```bash
cd /dpds/librealsense-2.50.0/
```

You may want better control of what's inside the image. To this matter you will find here : 

- Image *Dockerfile*.

- *docker-compose.yml* to start container automatically and for Kubernetes-like deployement. Note that stopping a container removes it. An external *app* directory is linked to the containers */app* one in order to provide a permanent save point.

- *Makefile* to provide usual commands

# Image prerequisites

- Ubuntu 20.04

- Docker (tested with Docker 20.10.7), see [Install Docker Engine](https://docs.docker.com/engine/install/)

- Docker Compose (tested with Docker Compose 1.29.2), see [Install Docker Compose](https://docs.docker.com/compose/install/)
  You may have a `/usr/local/bin/docker-compose: no such file or directory` error. In this case, use
  ```bash
  sudo mkdir /usr/local/bin/docker-compose
  ```
  before restarting the installation process

- Nvidia Container Toolkit (tested with ubuntu20.04 distribution), see [NVIDIA Container Toolkit Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

- A PC with GPU. Use the following to list available graphics units
  ```bash
  lshw -c display
  ```

# Image installation

```bash
docker pull lmwafer/realsense-ready:<desired tag>
```

# Image usage

All the commands need to be run in **realsense-2-ready** directory. 

Get inside a freshly new container (basically `up` + `enter`)
```bash
make
```

Start an *realsense-2-container* (uses **docker-compose.yml**)
```bash
make up
```

Enter running *realsense-2-container*
```bash
make enter
```

Stop running *realsense-2-container* (and removes it, by default only data in */app* is saved here in *app* directory)
```bash
make down
```

Build *realsense-2-ready* image (uses **Dockerfile**)
```bash
make build
```