#!/bin/bash

SHARED_LIB="ON"
ARM="ON"
ARM82="ON"
METAL="OFF"
DEBUG="OFF"
MODEL_CHECK="OFF"
PROFILE="OFF"
OPENMP="OFF"
TARGET_ARCH=aarch64

CC=`which clang`
CXX=`which clang++`

if [ $OPENMP == "ON" ]; then
    CC=/opt/homebrew/opt/llvm/bin/clang
    CXX=/opt/homebrew/opt/llvm/bin/clang++
    export LIBOMP_DIR=/opt/homebrew/opt/libomp/lib
fi

if [ -z $TNN_ROOT_PATH ]
then
    TNN_ROOT_PATH=$(cd `dirname $0`; pwd)/..
fi

rm -rf build_aarch64_macos
mkdir build_aarch64_macos
cd build_aarch64_macos

cmake ${TNN_ROOT_PATH} \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_COMPILER=$CXX \
    -DTNN_TEST_ENABLE=OFF \
    -DTNN_UNIT_TEST_ENABLE=ON \
    -DDEBUG:BOOL=$DEBUG \
    -DTNN_CPU_ENABLE=ON \
    -DTNN_ARM_ENABLE:BOOL=$ARM \
    -DTNN_ARM82_ENABLE:BOOL=$ARM82 \
    -DTNN_OPENCL_ENABLE:BOOL=$OPENCL \
    -DTNN_METAL_ENABLE:BOOL=$METAL \
    -DCMAKE_SYSTEM_PROCESSOR=$TARGET_ARCH \
    -DTNN_MODEL_CHECK_ENABLE=$MODEL_CHECK \
    -DTNN_PROFILER_ENABLE=$PROFILE \
    -DTNN_OPENMP_ENABLE:BOOL=$OPENMP \
    -DTNN_BUILD_SHARED:BOOL=$SHARED_LIB


make -j6
