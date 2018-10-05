#!/usr/bin/env bash

#Setup toolchain
axel --alternate --num-connections=$( echo $( nproc --all) + $( nproc --all) | bc ) --output=toolchain.tar.xz https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/arm-eabi/gcc-linaro-7.3.1-2018.05-x86_64_arm-eabi.tar.xz
tar -xf toolchain.tar.xz
mv *arm-eabi arm-eabi
#Set Variables
export CROSS_COMPILE="/usr/bin/ccache ./arm-eabi/bin/arm-eabi-" ;
export ARCH=arm;
export SUBARCH=arm;
export KBUILD_BUILD_USER="ist";
export KBUILD_BUILD_HOST="travis";
STRIP="arm-eabi/bin/arm-eabi-strip";
export CCOMPILE=$CROSS_COMPILE;
export CROSS_COMPILE="/usr/bin/ccache arm-eabi-" ;
export PATH=$PATH:./arm-eabi/bin/ ;

#Build
make harpia_defconfig;
make -j$( echo $( nproc --all) + $( nproc --all) | bc );