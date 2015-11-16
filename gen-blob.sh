CMDLINE=`cat ./kernel.LNX-config|grep "CMDLINE="|awk -FCMDLINE= '{print $2}'`
echo -e "Creating image with CMDLINE: \n$CMDLINE"
./bin/mkbootimg --kernel ./kernel.gz --ramdisk ./initramfs.cpio.gz -o installer.LNX --cmdline "$CMDLINE"
echo Creating blob
./bin/blobpack ./installer LNX ./installer.LNX
echo Cleaning debris
rm ./installer.LNX
