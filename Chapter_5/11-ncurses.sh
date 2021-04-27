name=ncurses
version=6.2
step=11
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
	sed -i s/mawk// configure
	./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite
            make
            make install
ln -s libncursesw.so /tools/lib/libncurses.so

rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
