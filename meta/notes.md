// attempt to build https://github.com/futurejones/swift-arm64 on armv7
// https://github.com/uraimo/buildSwiftOnARM

0. Follow the swap file instructions at buildSwiftOnARM

```
docker swarm join --token SWMTKN-1-3gqqplrd5nl0qh0sn9yevqnuhtyv534wi79ij6drjzbo4gbstz-6ortghq64fnoxblgj4jhjl3nm 192.168.1.150:2377
```

```
sudo fallocate -l 6G swapfile && sudo chmod 600 swapfile && sudo mkswap swapfile && sudo swapon swapfile
```

1. Follow steps on swift-arm64

```
sudo apt-get -q install -y git cmake ninja-build clang python python3.8 uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync python-six python3-dev python3-pip python3-tk python3-lxml python3-six

# for Swift 5.4 only
sudo apt-get install python3-dev python3-pip python3-tk python3-lxml python3-six
``` 

```
mkdir swift-source && cd swift-source && git clone https://github.com/apple/swift.git && ./swift/utils/update-checkout --clone --scheme "release/5.3"

mkdir swift-source && cd swift-source && git clone https://github.com/apple/swift.git && ./swift/utils/update-checkout --clone --scheme "swift-5.1-branch"

mkdir swift-source && cd swift-source && git clone https://github.com/apple/swift.git && ./swift/utils/update-checkout --clone --scheme "swift-5.2-branch"

mkdir swift-source && cd swift-source && git clone https://github.com/apple/swift.git && ./swift/utils/update-checkout --clone --scheme "release/5.3-20201012"

mkdir swift-source && cd swift-source && git clone https://github.com/apple/swift.git && ./swift/utils/update-checkout --clone --scheme "release/5.4"

```


```
# dry run build
./swift/utils/build-script -j=5 --preset=buildbot_linux,swiftlang-min install_destdir=/root/swift-source/install installable_package=/root/swift-source/install/swift-5.4-armv7-RELEASE-Ubuntu-18.04.tar.gz -n
```

```
# actual run build
./swift/utils/build-script -j=5 --preset=buildbot_linux,swiftlang-min install_destdir=/root/swift-source/install installable_package=/root/swift-source/install/swift-5.4-armv7-RELEASE-Ubuntu-18.04.tar.gz

./swift/utils/build-script -j=5 --preset=buildbot_linux,swiftlang-min install_destdir=/root/swift-source/install installable_package=/root/swift-source/install/swift-5.3-armv7-RELEASE-Ubuntu-18.04.tar.gz

./swift/utils/build-script -j=5 --preset=buildbot_linux_1804,notest install_destdir=/root/swift-source/install installable_package=/root/swift-source/install/swift-5.4-armv7-RELEASE-Ubuntu-18.04.tar.gz

#buildbot_linux_1804,notest
```

```
# install from tarball

tar -xvzf swift-5.4-armv7-RELEASE-Ubuntu-18.04.tar.gz -C ~/swift

# make tarball
tar -czvf swiftslim-5.4-armv7-RELEASE-Ubuntu-18.04.tar.gz ./usr


```

```
# path to install

export PATH="/root/buildSwiftOnARM/install/usr/bin:$PATH"

export PATH="/root/swift/usr/bin:$PATH"

```

```
# if gdb ends with sigill in libcrypto, this is normal suppress it
(gdb) handle SIGILL nostop noprint


```



```
# Add to utils/build-presets.ini
# pico swift/utils/build-presets.ini

#===------------------------------------------------------------------------===#
# Linux swiftlang-min
#===------------------------------------------------------------------------===#
[preset: buildbot_linux,swiftlang-min]
assertions
no-swift-stdlib-assertions
swift-enable-ast-verifier=0

swift-install-components=autolink-driver;compiler;clang-resource-dir-symlink;stdlib;swift-remote-mirror;sdk-overlay;parser-lib;license
llvm-install-components=llvm-cov;llvm-profdata;clang;clang-resource-headers;compiler-rt;clangd

build-ninja
release

install-prefix=/usr
build-subdir=buildbot_linux
install-destdir=%(install_destdir)s
installable-package=%(installable_package)s

build-swift-static-stdlib
build-swift-static-sdk-overlay

foundation
libdispatch
libicu

install-swift
install-swiftpm
install-foundation
install-libdispatch
install-libicu
reconfigure
#===------------------------------------------------------------------------===#
# End
#===------------------------------------------------------------------------===#
```


```

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wimplicit-int-float-conversion"
#pragma GCC diagnostic ignored "-Wimplicit-const-int-float-conversion"


#pragma GCC diagnostic pop


```