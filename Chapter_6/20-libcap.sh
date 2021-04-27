name=libcap
version=2.48

mkdir -pv /var/lib/scratchpkg/index/$name
checkfile=/var/lib/scratchpkg/index/$name/.pkginfo

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
	sed -i '/install.*STALIBNAME/d' libcap/Makefile
	make
	make RAISE_SETFCAP=no lib=lib prefix=/usr install
	chmod -v 755 /usr/lib/libcap.so.$version
	mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so
rm -rvf $name-$version

#add record to system install library
echo "name=$name" >> $checkfile
echo "version=$version" >> $checkfile
echo "release=1" >> $checkfile
fi