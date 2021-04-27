name=expect
version=5.45.4
step=08
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.*.*
cd $name-$version
cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure
./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include
make
make SCRIPTS="" install

rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
