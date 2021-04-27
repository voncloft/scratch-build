name=findutils
version=4.8.0

mkdir -pv /var/lib/scratchpkg/index/$name
checkfile=/var/lib/scratchpkg/index/$name/.pkginfo

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
sed -i 's/test-lock..EXEEXT.//' tests/Makefile.in
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c
sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c
echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h
./configure --prefix=/usr --localstatedir=/var/lib/locate
make
make install
mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb
rm -rvf $name-$version

#add record to system install library
echo "name=$name" >> $checkfile
echo "version=$version" >> $checkfile
echo "release=1" >> $checkfile
else
        echo "$name - Already installed - skipping"

fi
