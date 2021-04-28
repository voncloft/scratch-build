name=linux
version=5.11.16
step=02
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version
make mrproper
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr


rm -rfv /mnt/lfs/sources/$name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
