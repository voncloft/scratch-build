name=tar
version=1.34
step=28
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version
./configure --prefix=/tools
make
make install
rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
