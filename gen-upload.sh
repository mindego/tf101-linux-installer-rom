echo Uploading to sdcard...
mount /dev/sdj1 /mnt/temp
cp ./installer /mnt/temp/roms/
sync
umount /dev/sdj1