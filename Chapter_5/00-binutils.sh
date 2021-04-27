name=binutils
version=2.36.1
step=00
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar $name-$version.tar.xz
cd $name-$version

mkdir -v build
cd build

../configure --prefix=$LFS/tools       \
             --with-sysroot=$LFS        \
	     --with-lib-path=/tools/lib:/tools/lib32 \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror
mkdir -pv /tools/lib32
make
case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac
make install
rm -rfv $name-$version
touch $checkfile
else
	echo "$name - Already installed - skipping"
fi
