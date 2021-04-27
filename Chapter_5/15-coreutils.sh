name=coreutils
version=8.32
step=15
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
./configure --prefix=/tools --enable-install-program=hostname
make
make install
rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
