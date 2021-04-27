name=dejagnu
version=1.6.2
step=09
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version
./configure --prefix=/tools
make install

rm -rfv /mnt/lfs/sources/$name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
