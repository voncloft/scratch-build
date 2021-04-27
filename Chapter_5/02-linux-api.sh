name=linux
version=5.10.17
step=02
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
make mrproper
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include

rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
