name=glibc
version=2.33
gcc)version=10.2.0
step=03
checkfile=/logs/$step-$name-$version
if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version

ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3

patch -Np1 -i ../glibc-$version-fhs-1.patch
mkdir -v build
cd       build
../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      --enable-multi-arch                \
      --libdir=/usr/lib                  \
      --libexecdir=/usr/lib              \
      libc_cv_slibdir=/lib


make
make DESTDIR=$LFS install
$LFS/tools/libexec/gcc/$LFS_TGT/$gcc_version/install-tools/mkheaders

make clean
find .. -name "*.a" -delete

CC="$LFS_TGT-gcc -m32" \
CXX="$LFS_TGT-g++ -m32" \
../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT32                  \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      --enable-multi-arch                \
      --libdir=/usr/lib32                \
      --libexecdir=/usr/lib32            \
      libc_cv_slibdir=/lib32

make
make DESTDIR=$PWD/DESTDIR install
cp -a DESTDIR/lib32/*     $LFS/lib32/
cp -a DESTDIR/usr/lib32 $LFS/usr/
###need to fix
install -vm644 DESTDIR/usr/include/gnu/{lib-names,stubs}-32.h \
               $LFS/usr/include/gnu/
ln -svf ../lib32/ld-linux.so.2 $LFS/lib/ld-linux.so.2


make clean
find .. -name "*.a" -delete

CC="$LFS_TGT-gcc -mx32" \
CXX="$LFS_TGT-g++ -mx32" \
../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGTX32                 \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      --enable-multi-arch                \
      --libdir=/usr/libx32               \
      --libexecdir=/usr/libx32           \
      libc_cv_slibdir=/libx32

make
make DESTDIR=$PWD/DESTDIR install
cp -a DESTDIR/libx32/*     $LFS/libx32/
cp -a DESTDIR/usr/libx32 $LFS/usr/
###need to fix
install -vm644 DESTDIR/usr/include/gnu/{lib-names,stubs}-x32.h \
               $LFS/usr/include/gnu/
ln -svf ../libx32/ld-linux-x32.so.2 $LFS/lib/ld-linux-x32.so.2





rm -rfv /mnt/lfs/sources/$name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
