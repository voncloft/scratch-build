name=bzip2
version=1.0.8
step=14
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version
make
make PREFIX=/tools install

rm -rfv /mnt/lfs/sources/$name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
