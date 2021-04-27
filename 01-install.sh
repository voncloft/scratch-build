#ask for partition
echo "What partition name will be used for the root partition?"
read drive
#create partition
mkfs.ext4 /dev/$drive

#create and mount working directory
echo "Setting LFS variable partition to /mnt/lfs and mounting drive"
LFS=/mnt/lfs
mkdir -pv $LFS
mount -v -t ext4 /dev/$drive $LFS

echo "Creating sources folder and grabbing packages"
#create package directory
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
wget --input-file=files/wget-list --continue --directory-prefix=$LFS/sources

echo "Creating tools directory"
mkdir -v $LFS/tools
ln -sv $LFS/tools /

echo "Creating lfs user"
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

###Find way to passwd lfs
#passwd lfs

chown -v lfs $LFS/tools
chown -v lfs $LFS/sources
su - lfs

echo "Setting up environment"
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF
source ~/.bash_profile

mkdir -pv /logs
chown -R  lfs:lfs /logs
chmod -R 777 /logs

cd $LFS/sources
for f in Chapter_5/*;
do
	sh $f
done
chown -R root:root $LFS/tools
echo "Move your folder into /mnt/lfs and start on chaper 6"
echo "Please chroot into the new environment by executing the following as root"
echo "chroot "$LFS" /tools/bin/env -i \ HOME=/root \TERM="$TERM" \PS1='(lfs chroot) \u:\w\$ ' \PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \ /tools/bin/bash --login +h"
