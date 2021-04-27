name=glibc
version=2.33
step=03
checkfile=/logs/$step-$name-$version
if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version

mkdir -v build32
cd       build32
	
echo slibdir=/tools/lib32 > configparms
../configure                             \
	  --prefix=/tools                    \
	  --host=i686-lfs-linux-gnu          \
	  --build=$(../scripts/config.guess) \
	  --libdir=/tools/lib32              \
	  --enable-kernel=3.2                \
	  --enable-add-ons                   \
	  --with-headers=/tools/include      \
	  libc_cv_forced_unwind=yes          \
	  libc_cv_c_cleanup=yes              \
	  CC="$LFS_TGT-gcc -m32"             \
	  CXX="$LFS_TGT-g++ -m32"
make
make install

cd ..
mkdir -v build
cd       build
../configure                             \
      --prefix=/tools                    \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=/tools/include

make
make install
rm -rfv /mnt/lfs/sources/$name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
