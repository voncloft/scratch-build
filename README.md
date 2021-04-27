NEEDS TESTING - HAVE NOT DONE YET - I am definately sure there are errors to this script

I used the 8.4 lfs layout to install packages while using the most up to date packages of of 4/27/21


How to use this script:

scripts/version-check.sh: used to check host OS

./01-install.sh: run as normal user

Copy folder inside /mnt/lfs - cd into it once chrooted

./02-install.sh: manually chroot into environment as root: 

LFS=/mnt/lfs

chroot "$LFS" /tools/bin/env -i \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h


./03-finishingup.sh: use as root - chroot as follows:

LFS=/mnt/lfs

chroot "$LFS" /usr/bin/env -i          \
    HOME=/root TERM="$TERM"            \
    PS1='(lfs chroot) \u:\w\$ '        \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login

Follow finishing prompts on 3rd phase
