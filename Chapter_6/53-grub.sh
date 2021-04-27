name=grub
version=2.04

mkdir -pv /var/lib/scratchpkg/index/$name
checkfile=/var/lib/scratchpkg/index/$name/.pkginfo

if [ ! -f $checkfile ];
then
cd /sources
tar xvf $name-$version.*.*
cd $name-$version
	./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror
            make
            make install
            mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

rm -rfv /sources/$name-$version

#add record to system install library
echo "name=$name" >> $checkfile
echo "version=$version" >> $checkfile
echo "release=1" >> $checkfile
else
        echo "$name - Already installed - skipping"

fi
