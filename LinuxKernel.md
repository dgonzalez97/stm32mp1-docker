git clone -b baw-v6.1-stm32mp https://github.com/bytesatwork/linux-stm32mp.git
cd linux-stm32mp

source /opt/poky-bytesatwork/5.0.3/environment-setup-cortexa7t2hf-neon-vfpv4-poky-linux-gnueabi


make multi_v7_defconfig
scripts/kconfig/merge_config.sh -m -r .config arch/arm/configs/fragment-*
make olddefconfig

make LOADADDR=0xC2000040 -j$(nproc) uImage stm32mp157c-bytedevkit-v1-3.dtb modules

mkdir /tmp/bytedevkit-stm32mp1
make INSTALL_MOD_PATH=/tmp/bytedevkit-stm32mp1 modules_install
