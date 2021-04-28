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

echo "Creating filesystem"
mkdir -pv $LFS/{bin,etc,lib,sbin,usr,var}
case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac
mkdir -pv $LFS/lib{,x}32
mkdir -pv $LFS/tools

echo "Creating lfs user"
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

###Find way to passwd lfs
#passwd lfs
chown -v lfs $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac
chown -v lfs $LFS/{lib32,libx32}

mkdir -pv /logs
chown -v lfs /logs
chmod 777 /logs

chown -v lfs $LFS/tools
chown -v lfs $LFS/sources
su - lfs
