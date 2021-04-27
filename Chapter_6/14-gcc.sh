name=gcc
version=10.2.0

mkdir -pv /var/lib/scratchpkg/index/$name
checkfile=/var/lib/scratchpkg/index/$name/.pkginfo

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac
rm -f /usr/lib/gcc
mkdir -v build
cd       build
SED=sed                               \
../configure --prefix=/usr            \
             --enable-languages=c,c++ \
             --enable-multilib       \
             --disable-bootstrap      \
             --disable-libmpx         \
             --with-system-zlib
             make
             make install
             ln -sv ../usr/bin/cpp /lib
             ln -sv gcc /usr/bin/cc
             install -v -dm755 /usr/lib/bfd-plugins
	ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/8.2.0/liblto_plugin.so \
        /usr/lib/bfd-plugins/
        mkdir -pv /usr/share/gdb/auto-load/usr/lib
        mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
        
rm -rvf $name-$version

#add record to system install library
echo "name=$name" >> $checkfile
echo "version=$version" >> $checkfile
echo "release=1" >> $checkfile
fi
