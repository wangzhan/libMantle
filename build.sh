#!/bin/sh

OBJ="./objs"
LIBNAME="libMantle.a"
ARCHS="-arch armv7 -arch armv7s -arch arm64"

SDK=$(ls -1d /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iP* | tail -n1)
echo $SDK

# remove object files to build nice n clean
echo '[+] Removing old object files ...'
rm -Rf ${OBJ}
mkdir ${OBJ}

# compile the Objective-C stuff
echo '[+] Compiling Objective-C files ...'
CLANG_CFLAGS="-Wno-format -Wno-mismatched-parameter-types -Wno-unused-function -Wno-deprecated-declarations -Wno-enum-conversion"
cd ${OBJ}
clang -c ../*.m ${ARCHS} -isysroot $SDK ${CLANG_CFLAGS}

# See Makefile.* in the parent directory.
echo "[+] Creating ${LIBNAME} archive"
ar -rs ${LIBNAME} *.o >/dev/null 2>&1

mv -f ${LIBNAME} ../../
echo '[+] done.'
