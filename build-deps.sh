#!/usr/bin/env bash

rm -rf ./deps-build
rm -rf ./deps-install
mkdir -p ./deps-build

ZLIB=zlib-1.3.1
echo "Downloading ZLIB sources..."
curl https://www.zlib.net/$ZLIB.tar.gz --silent --output deps-build/$ZLIB.tar.gz

LIBPNG=libpng-1.6.43
echo "Downloading libpng sources..."
curl --location http://prdownloads.sourceforge.net/libpng/$LIBPNG.tar.gz?download --silent --output deps-build/$LIBPNG.tar.gz

tar xzf deps-build/$ZLIB.tar.gz --directory deps-build && rm deps-build/$ZLIB.tar.gz
tar xzf deps-build/$LIBPNG.tar.gz --directory deps-build && rm deps-build/$LIBPNG.tar.gz

echo "Building zlib..."
ZLIB_INSTALL=$(pwd)/deps-install/zlib
cmake -S deps-build/$ZLIB -B deps-build/$ZLIB/build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ZLIB_INSTALL
cmake --build deps-build/$ZLIB/build
cmake --install deps-build/$ZLIB/build

echo "Building libpng..."
LIBPNG_INSTALL=$(pwd)/deps-install/libpng
cmake -S deps-build/$LIBPNG -B deps-build/$LIBPNG/build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$LIBPNG_INSTALL -DZLIB_ROOT=$ZLIB_INSTALL -DPNG_FRAMEWORK=OFF -DPNG_STATIC=OFF
cmake --build deps-build/$LIBPNG/build
cmake --install deps-build/$LIBPNG/build