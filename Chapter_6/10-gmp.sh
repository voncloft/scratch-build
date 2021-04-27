name=6mp
version=6.2.1

mkdir -pv /var/lib/scratchpkg/index/$name
checkfile=/var/lib/scratchpkg/index/$name/.pkginfo

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-$version
            make
            make install
            
rm -rvf $name-$version

#add record to system install library
echo "name=$name" >> $checkfile
echo "version=$version" >> $checkfile
echo "release=1" >> $checkfile
fi
