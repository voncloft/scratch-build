name=bash
version=5.1
step=12
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version
./configure --prefix=/tools --without-bash-malloc
make
make install
ln -sv bash /tools/bin/sh
rm -rfv /mnt/lfs/sources/$name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
