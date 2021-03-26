#!/bin/bash
. "$(dirname $0)/utils.sh"

REL=5.4
INSTALL_DIR=`pwd`/install
PACKAGE=`pwd`/swift-${REL}_${ARCH}.tgz

./swift/utils/build-script -j=5 --preset=buildbot_linux_1804,notest install_destdir=/root/swift-source/install installable_package=/root/swift-source/install/swift-$REL-armv7-RELEASE-Ubuntu-18.04.tar.gz

#./swift/utils/build-script \
#    -R \
#    --build-subdir buildbot_linux --install-prefix=/usr \
#    --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE} \
#    --lldb --llbuild --xctest --swiftpm --foundation --libdispatch \
#    -- --install-libdispatch --install-foundation --install-swift --install-lldb --install-llbuild --install-xctest --install-swiftpm \
#    '--swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;swift-remote-mirror;sdk-overlay;dev' \
#    --build-swift-static-stdlib --build-swift-static-sdk-overlay


