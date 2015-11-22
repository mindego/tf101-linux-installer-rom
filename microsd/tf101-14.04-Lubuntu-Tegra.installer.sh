# This is a second-stage installer script.
# Please do not delete following line:
# MAGICSTRING=136f5e3b2b12c40cea97abe7c9bff368
# This is a "failsafe" method to detect rootfs installers
# By the way, that is md5sum of "This is a linux installer for TF101"

NAME="Lubuntu 14.04"
TARBALL_DEVICE=/dev/mmcblk1p1
TARBALL=tf101-14.04-Lubuntu-Tegra-armaf.tar.gz
KERNEL=blob
KERNELZIP=Ubuntu-3.1.10-15-rootbind-oc1.5.zip
INSTALL_DEVICE=/dev/mmcblk0p7
INSTALL_DIRECTORY=lubuntu.14.04
ROOTFS_DIRECTORY=linux.root
SYMLINK_ROOT=linuxroot


echo -e "Installing $NAME to $ROOTFS_DIRECTORY/$INSTALL_DIRECTORY on $INSTALL_DEVICE from $TARBALL image on $TARBALL_DEVICE"

# Mount the root filesystem
echo Mounting data partition...
mount -t ext4 -o noatime,nodiratime,errors=panic $INSTALL_DEVICE /mnt/root

# echo Mounting sdcard...
# already mounted in main installer script
# mount $TARBALL_DEVICE /mnt/sdcard

if [ ! -z "$TARBALL" ]
then
    echo Creating rootfs directories...
    mkdir -p /mnt/root/$ROOTFS_DIRECTORY/$INSTALL_DIRECTORY
    chmod 755 /mnt/root/$ROOTFS_DIRECTORY/$INSTALL_DIRECTORY

    #mkdir -p /mnt/root/$SYMLINK_ROOT
    #chmod 755 /mnt/root/$SYMLINK_ROOT
    cd /mnt/root/$ROOTFS_DIRECTORY/$INSTALL_DIRECTORY
    echo Unpacking rootfs...
    #tar -pxvzf /mnt/sdcard/$TARBALL
    bar -n /mnt/sdcard/$TARBALL | tar -pxzf -
else
    echo No rootfs for install.
fi

echo Flashing kernel blob...
if [ ! -z "$KERNELZIP" ]
then
    echo Kernel is zipped. Unpacking...
    unzip /mnt/sdcard/$KERNELZIP $KERNEL -d /tmp
else
    cp /mnt/sdcard/$KERNEL /tmp
fi

dd if=/tmp/$KERNEL of=/dev/mmcblk0p4

echo Symlinking rootfs directory...
rm /mnt/root/$SYMLINK_ROOT
cd /mnt/root
ln -s $ROOTFS_DIRECTORY/$INSTALL_DIRECTORY $SYMLINK_ROOT

echo $NAME is successfully installed.
