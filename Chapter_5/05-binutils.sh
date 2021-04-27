name=binutils
version=2.32
step=05
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
cd /mnt/lfs/sources
tar xvf $name-$version.*.*
cd $name-$version
	mkdir -v build
	cd       build

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysrootrm -rvf $name-$version

make
make install
make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib:/usr/lib32:/lib32
cp -v ld/ld-new /tools/bin

touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
