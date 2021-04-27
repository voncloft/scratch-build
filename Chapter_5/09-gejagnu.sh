name=dejagnu
version=1.6.2
step=09
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
./configure --prefix=/tools
make install

rm -rvf $name-$version
touch $checkfile
fi
