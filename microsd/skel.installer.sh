# MAGICSTRING=30ea1a413af7be981c355b3b5e27bc1f
# This is a "failsafe" method to detect rootfs installers

NAME="Ubuntu 15.10"
TARBALL_DEVICE=/dev/mmcblk1p1
TARBALL=wily.mate.tar.gz
KERNEL=kernel.blob
INSTALL_DEVICE=/dev/mmcblk0p7
INSTALL_DIRECTORY=/linuxroot/ubuntu.wily
SYMLINK_ROOT=/linux.root

echo -e "Installing $NAME to $INSTALL_DIRECTORY on $INSTALL_DEVICE from $TARBALL image on $TARBALL_DEVICE"

# Mount the root filesystem
echo Mounting data partition...
mount -t ext4 -o noatime,nodiratime,errors=panic $INSTALL_DEVICE /mnt/root

echo Mounting sdcard...
mount $TARBALL_DEVICE /mnt/sdcard

echo Creating rootfs directories...
mkdir -p /mnt/root/$INSTALL_DIRECTORY
chmod 755 /mnt/root/$INSTALL_DIRECTORY
rm /mnt/root/$SYMLINK_ROOT
#mkdir -p /mnt/root/$SYMLINK_ROOT
#chmod 755 /mnt/root/$SYMLINK_ROOT
cd /mnt/root/$INSTALL_DIRECTORY

echo Unpacking rootfs...
#tar -pxvzf /mnt/sdcard/$TARBALL
bar -n /mnt/sdcard/$TARBALL | tar -pxzf -

echo Flashing kernel blob...
dd if=/mnt/sdcard/$KERNEL of=/dev/mmcblk0p4

echo Symlinking rootfs directory...
cd /mnt/root
ln -s linuxroot/`basename $INSTALL_DIRECTORY` `basename $SYMLINK_ROOT`

echo $NAME is successfully installed.