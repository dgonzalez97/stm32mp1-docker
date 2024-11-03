# STM32MP1 Yocto Development Environment Setup

This document provides the steps to set up the Yocto development environment inside the Docker container.

---

## Building the Docker Image

```bash
docker build -t stm32mp1-yocto .

docker run -it --rm -v $(pwd)/workdir:/home/developer/workdir stm32mp1-yocto    #For data persnistency

##inside the container ()
chmod +x initial-repo-setup.sh
./initial-repo-setup.sh

##This will initialice the yocto repo from BaW

cd $YOCTO_DIR
MACHINE=bytedevkit-stm32mp1 DISTRO=poky-bytesatwork EULA=1 . setup-environment build

bitbake bytesatwork-minimal-image

# To populate the toolchain (not yet tested)

bitbake bytesatwork-minimal-image -c populate_sdk
cd $BUILDDIR/tmp/deploy/sdk/
