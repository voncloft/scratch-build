name=binutils
version=2.36.1
step=00
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version

mkdir -v build
cd build

../configure --prefix=$LFS/tools       \
             --with-sysroot=$LFS        \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror           \
             --enable-multilib
make
make install
rm -rf /mnt/lfs/sources/$name-$version
touch $checkfile
else
	echo "$name - Already installed - skipping"
fi
