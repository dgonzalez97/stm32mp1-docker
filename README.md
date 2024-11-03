# STM32MP1 Yocto Development Environment Setup

This document provides the steps to set up the Yocto development environment inside the Docker container.

---

## Building the Docker Image

```bash
docker build -t stm32mp1-yocto .

docker run -it --rm -v $(pwd)/workdir:/home/developer/workdir stm32mp1-yocto    #For data persnistency

##inside the container ()

mkdir -p $YOCTO_DIR
cd $YOCTO_DIR

# Initialize repo -- https://bytewiki.readthedocs.io/en/latest/yocto/5.0/bytedevkit-stm32mp1.html#downloads
repo init -b scarthgap -u https://github.com/bytesatwork/bsp-platform-st.git
repo sync

cd $YOCTO_DIR
MACHINE=bytedevkit-stm32mp1 DISTRO=poky-bytesatwork EULA=1 . setup-environment build

cd $BUILDDIR
bitbake bytesatwork-minimal-image

# To populate the toolchain (not yet tested)

bitbake bytesatwork-minimal-image -c populate_sdk
cd $BUILDDIR/tmp/deploy/sdk/
