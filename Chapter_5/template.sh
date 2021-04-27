name=
version=
step=
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version
cd $name-$version

rm -rvf $name-$version
touch $checkfile
fi
