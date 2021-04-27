name=gcc
version=10.2.0
step=06
checkfile=/logs/$step-$name-$version
mpfr=4.1
gmp=6.2.1
mpc=1.2.1
if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  	`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

	for file in gcc/config/{linux,i386/linux{,64}}.h
	do
  	cp -uv $file{,.orig}
  	sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      	-e 's@/usr@/tools@g' $file.orig > $file
  	echo '
	#undef STANDARD_STARTFILE_PREFIX_1
	#undef STANDARD_STARTFILE_PREFIX_2
	#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
	#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  	touch $file.orig
	sed -i -e 's@/lib/ld-linux.so.2@/lib32/ld-linux.so.2@g' gcc/config/i386/linux64.h
	sed -i -e '/MULTILIB_OSDIRNAMES/d' gcc/config/i386/t-linux64
	echo "MULTILIB_OSDIRNAMES = m64=../lib m32=../lib32 mx32=../libx32" >> gcc/config/i386/t-linux64

tar -xf ../mpfr-$mpfr.tar.xz
mv -v mpfr-$mpfr.tar.xz mpfr
tar -xf ../gmp-$gmp.tar.xz
mv -v gmp-$gmp gmp
tar -xf ../mpc-$mpc.tar.gz
mv -v mpc-$mpc mpc

mkdir -v build
cd       build

CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../configure                                       \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --with-multilib-list=m32,m64                             \
    --disable-bootstrap                            \
    --disable-libgomp
done
make
make install
ln -sv gcc /tools/bin/cc
rm -rvf $name-$version
touch $checkfile
fi
