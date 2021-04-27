name=gcc
version=10.2.0
step=01

mpfr=4.1.0
gmp=6.2.1
mpc=1.2.1
glibc=2.33
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version

tar -xf ../mpfr-$mpfr.*.*
mv -v mpfr-$mpfr mpfr
tar -xf ../gmp-$gmp.*.*
mv -v gmp-$gmp gmp
tar -xf ../mpc-$mpc.tar.gz
mv -v mpc-$mpc mpc

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
done

sed -i -e 's@/lib/ld-linux.so.2@/lib32/ld-linux.so.2@g' gcc/config/i386/linux64.h
sed -i -e '/MULTILIB_OSDIRNAMES/d' gcc/config/i386/t-linux64
echo "MULTILIB_OSDIRNAMES = m64=../lib m32=../lib32 mx32=../libx32" >> gcc/config/i386/t-linux64

mkdir -v build
cd       build

../configure                                       \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=$glibc                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --with-multilib-list=m32,m64                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libmpx                               \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++

make
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
rm -vf $name-$version
touch $checkfile

else
        echo "$name - Already installed - skipping"

fi
