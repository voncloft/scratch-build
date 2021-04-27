name=sed
version=4.8
step=27
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
	./configure --prefix=/tools
	make
	make install
rm -rvf $name-$version
touch $checkfile
else
        echo "$name - Already installed - skipping"

fi
