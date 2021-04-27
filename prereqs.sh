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
