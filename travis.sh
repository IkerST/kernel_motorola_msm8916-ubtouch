#!/usr/bin/env bash

#Setup toolchain
git clone https://github.com/IkerST/toolchains.git toolchain --single-branch --depth=1 -j$(nproc --all)

#Set Variables
TOOLCHAINDIR=$(pwd)/toolchain/linaro-7.2
export CROSS_COMPILE="/usr/bin/ccache $TOOLCHAINDIR/bin/arm-eabi-"
export CCOMPILE=$CROSS_COMPILE
export ARCH=arm
export KBUILD_BUILD_USER="ist"
export KBUILD_BUILD_HOST="travis"

#Build
make harpia_defconfig
make -j$( echo $( nproc --all) + $( nproc --all) | bc )