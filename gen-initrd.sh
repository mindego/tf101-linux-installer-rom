echo Generating initrd image...
rm ./initramfs.cpio.gz
cd initrd
find . | cpio --quiet -H newc -o | lzma -7 > ../initramfs.cpio.gz
cd ..