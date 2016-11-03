#!/bin/sh

BASE=../../../vendor/asus/tf701t/proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-files.txt`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    rsync -v -a /system/$FILE $BASE/$FILE
done

./setup-makefiles.sh
