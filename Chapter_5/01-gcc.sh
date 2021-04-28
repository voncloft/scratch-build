name=gcc
version=10.2.0
step=01

mpfr=4.1.0
gmp=6.2.1
mpc=1.2.1
glibc=2.33
isl=0.22.1
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
tar -xf ../isl-$isl.tar.xz
mv -v isl-$isl isl


sed -e '/m64=/s/lib64/lib/' \
    -e '/m32=/s/m32=.*/m32=..\/lib32$(call if_multiarch,:i386-linux-gnu)/' \
    -i.orig gcc/config/i386/t-linux64



mkdir build
cd build

mlist=m64,m32,mx32
../configure                                       \
    --target=$LFS_TGT                              \
    --prefix=$LFS/tools                            \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --enable-initfini-array                        \
    --disable-nls                                  \
    --disable-shared                               \
    --enable-multilib --with-multilib-list=$mlist  \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
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
touch $checkfile

else
        echo "$name - Already installed - skipping"

fi
