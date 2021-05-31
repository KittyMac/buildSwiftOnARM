#!/bin/bash
. "$(dirname $0)/utils.sh"

REL=5.5
INSTALL_DIR=`pwd`/install
PACKAGE=`pwd`/swift-${REL}_${ARCH}.tgz

./swift/utils/build-script -j=3 --preset=buildbot_linux,swiftlang-min install_destdir=/root/buildSwiftOnARM/install installable_package=/root/buildSwiftOnARM/install/swift-$REL-armv7-RELEASE-Ubuntu-18.04.tar.gz

#./swift/utils/build-script -j=5 --preset=buildbot_linux install_destdir=/root/buildSwiftOnARM/install installable_package=/root/buildSwiftOnARM/install/swift-$REL-armv7-RELEASE-Ubuntu-18.04.tar.gz

#./swift/utils/build-script \
#    -R \
#    --build-subdir buildbot_linux --install-prefix=/usr \
#    --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE} \
#    --lldb --llbuild --xctest --swiftpm --foundation --libdispatch \
#    -- --install-libdispatch --install-foundation --install-swift --install-lldb --install-llbuild --install-xctest --install-swiftpm \
#    '--swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;swift-remote-mirror;sdk-overlay;dev' \
#    --build-swift-static-stdlib --build-swift-static-sdk-overlay


