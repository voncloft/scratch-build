name=linux
version=5.10.17

tar xvf $name-$version
cd $name-$version
make mrproper
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include

rm -rvf $name-$version
