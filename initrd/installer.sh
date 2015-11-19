#Main installer script.
#Yes, it is quite ugly.

MAGICSTRING='136f5e3b2b12c40cea97abe7c9bff368'
TARBALL_DEVICE=/dev/mmcblk1p1
SDCARD=/mnt/sdcard



echo Mounting sdcard...
mount $TARBALL_DEVICE $SDCARD

echo Enumerating RootFS installers..
INSTALLERS=`grep $MAGICSTRING $SDCARD/*.installer.sh -r -l`
COUNT=0
for SELECTED_INSTALLER in $INSTALLERS
    do
	COUNT=`expr $COUNT + 1`
	echo [$COUNT] `basename $SELECTED_INSTALLER`
    done

unset SELECTED_INSTALLER
while [ -z "$SELECTED_INSTALLER" ]
do 

read -p "Please select desired installer and press <ENTER>:" INSTALLER

#Check for someone crafty...

#removing anything but numbers from user input
INSTALLER=`echo $INSTALLER|sed 's/[^0-9]*//g'`

#Are there something left?
if [ -z "$INSTALLER" ];then echo "Please input installer number.";unset INSTALLER;fi
#Is it in acceptable range?
if [ "$INSTALLER" -gt "$COUNT" ]; then echo "Please use one of number above.";unset INSTALLER;fi

if [ ! -z "$INSTALLER" ]; then SELECTED_INSTALLER=`echo $INSTALLERS|cut -f $INSTALLER -d " "`;fi

done
echo Executing second-stage linux installer...
/sbin/busybox sh $SELECTED_INSTALLER
