name=autoconf
version=2.71

mkdir -pv /var/lib/scratchpkg/index/$name
checkfile=/var/lib/scratchpkg/index/$name/.pkginfo

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
sed '361 s/{/\\{/' -i bin/autoscan.in
./configure --prefix=/usr
make
make install
rm -rvf $name-$version

#add record to system install library
echo "name=$name" >> $checkfile
echo "version=$version" >> $checkfile
echo "release=1" >> $checkfile
else
        echo "$name - Already installed - skipping"

fi