#!/bin/bash
LANG="ru_RU.UTF-8"

if [ "$#" -ne 1 ]
then 
   echo "Вам нужно ввести параметр"
   echo "Напишите: ./create_part <size part in Mb>"
   exit 1
fi

if [[ ! "$1" =~ ^-?[0-9]+$ ]]
then
   echo "Размер должен быть числом"
   exit 1
fi
size_part=$1

#создаем вирт раздел 

cd $HOME
date_time=$(date +"%Y-%m-%d_%H-%M-%S")
touch virtual_part_$date_time.img 
chmod a+x virtual_part_$date_time.img

#заполняем вирт диск
 
path_part="$HOME/virtual_part_$date_time.img"
dd if=/dev/zero of=$path_part bs=1M count=$size_part 2> /dev/null 1> /dev/null

#добавляем файловую систему 

mkfs.ext4 $path_part  2> /dev/null 1> /dev/null




