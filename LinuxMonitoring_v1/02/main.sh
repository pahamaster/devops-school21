#!/bin/bash

date=$(date +'%d_%m_%y_%H_%M_%S')
file=$(echo "$date.status")

./name.sh > $file
./time.sh >> $file
./net.sh >> $file
./ram.sh >> $file
./root.sh >> $file

cat $file
echo

echo -n "Write data to a file?(Y/N)"
read answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]
then
  rm $file
fi

