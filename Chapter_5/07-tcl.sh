name=tcl
version=8.6.11
step=07
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.*.*
cd $name-$version
cd unix
./configure --prefix=/tools
make
make install
chmod -v u+w /tools/lib/libtcl8.6.so
make install-private-headers
ln -sv tclsh8.6 /tools/bin/tclsh
rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
