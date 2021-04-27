name=bison
version=3.7.5
step=13
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
fi
