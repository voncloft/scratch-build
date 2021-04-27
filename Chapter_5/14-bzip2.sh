name=bzip2
version=1.0.8
step=14
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.*.*
cd $name-$version
make
make PREFIX=/tools install

rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
