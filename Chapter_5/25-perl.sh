name=perl
version=5.32.1
step=25
checkfile=/logs/$step-$name-$version

if [ ! -f $checkfile ];
then
tar xvf $name-$version.tar.xz
cd $name-$version
sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth
make
cp -v perl cpan/podlators/scripts/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/$version
cp -Rv lib/* /tools/lib/perl5/$version
rm -rvf $name-$version
touch $checkfile
fi
