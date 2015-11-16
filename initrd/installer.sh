name="Ubuntu 15.10"
tarball_device=/dev/mmcblk1p1
tarball=wily.mate.tar.gz
kernel=kernel.blob
install_device=/dev/mmcblk0p7
install_directory=/linuxroot/ubuntu.wily
symlink_root=/linux.root

echo -e "Installing $name to $install_directory on $install_device from $tarball image on $tarball_device"
# Mount the root filesystem, second partition on micro SDcard
echo Mounting data partition...
mount -t ext4 -o noatime,nodiratime,errors=panic /dev/mmcblk0p7 /mnt/root

echo Mounting sdcard...
mount /dev/mmcblk1p1 /mnt/sdcard

echo Creating rootfs directories...
mkdir -p /mnt/root/$install_directory
chmod 755 /mnt/root/$install_directory
rm /mnt/root/$symlink_root
#mkdir -p /mnt/root/$symlink_root
#chmod 755 /mnt/root/$symlink_root
cd /mnt/root/$install_directory

echo Unpacking rootfs...
#tar -pxvzf /mnt/sdcard/$tarball
bar -n /mnt/sdcard/$tarball | tar -pxzf -

echo Flashing kernel blob...
dd if=/mnt/sdcard/$kernel of=/dev/mmcblk0p4

echo Symlinking rootfs directory...
cd /mnt/root
ln -s linuxroot/`basename $install_directory` `basename $symlink_root`

echo $name is successfully installed.