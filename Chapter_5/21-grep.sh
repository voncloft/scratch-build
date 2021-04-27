name=grep
version=3.6
step=21
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
./configure --prefix=/tools
make
make install
rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
