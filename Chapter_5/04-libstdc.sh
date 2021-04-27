name=gcc
version=10.2.0
step=04
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.*.*
cd $name-$version
	mkdir -v build32
	cd       build32

	../libstdc++-v3/configure           \
	--host=i686-lfs-linux-gnu       \
	--prefix=/tools                 \
	--libdir=/tools/lib32           \
	--disable-multilib              \
	--disable-nls                   \
	--disable-libstdcxx-threads     \
	--disable-libstdcxx-pch         \
	--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/$version \
	CC="$LFS_TGT-gcc -m32"          \
	CXX="$LFS_TGT-g++ -m32"
	make
	make install

	cd ..
	mkdir -v build
	cd       build


	../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/$version
    make
    make install
rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
