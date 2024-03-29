name=bash
version=5.1

mkdir -pv /var/lib/scratchpkg/index/$name
checkfile=/var/lib/scratchpkg/index/$name/.pkginfo

if [ ! -f $checkfile ];
then
cd /sources
tar xvf $name-$version.*.*
cd $name-$version
./configure --prefix=/usr                    \
            --docdir=/usr/share/doc/bash-5.0 \
            --without-bash-malloc            \
            --with-installed-readline
           make
           make install
mv -vf /usr/bin/bash /bin
exec /bin/bash --login +h
rm -rfv /sources/$name-$version

#add record to system install library
echo "name=$name" >> $checkfile
echo "version=$version" >> $checkfile
echo "release=1" >> $checkfile
else
        echo "$name - Already installed - skipping"

fi
