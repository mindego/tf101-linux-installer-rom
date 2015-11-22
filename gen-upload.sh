echo Uploading to sdcard...
mount /dev/sdj1 /mnt/temp
cp ./installer /mnt/temp/roms/
cp ./microsd/tf101-14.04-Lubuntu-Tegra.installer.sh /mnt/temp
sync
umount /dev/sdj1