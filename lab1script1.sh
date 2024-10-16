#!/bin/bash
LANG="ru_RU.UTF-8"

#корректность ввода

if [ "$#" -ne 4 ]
then
   echo 'Вы ввели мало параметров'
   echo  'Напишите: ./lab1script1.sh <path directory> <X% fullness of directory for archiving> <N archived files> <path directory_arh>'
   exit 1
fi

#проверка на корректность пути и на существование диска(dev/null-специальный файл и все, что попадает туда, исчезает)

ls $1 2> /dev/null 1> /dev/null
if [ "$?" -ne 0 ]
then
   echo "Передаваемой директории не существует"
   exit 1
fi

ls $4 2> /dev/null 1> /dev/null
if [ "$?" -ne 0 ]
then
   echo "Директории, в которую вы хотите заархивировать файлы, не существует"
   exit 1
fi

#проверка N

count_file=$(ls -1 $1 | wc -l)
if [ "$3" -gt $count_file ] || [ "$2" -lt 0 ] || [ "$2" -gt 100 ]
then
   echo 'Количество файлов в переданной папке должно быть больше или равно N =' $3
   exit 1
fi

path_dir=$1
fullness_X=$2
N=$3
path_backup=$4

#находим последний виртуальные раздел, если отсутствует, возвращаем подсказку

vir_part=$(ls -t virtual_part_*.img 2> /dev/null | head -1)
if [ "$?" -ne 0 ]
then
    echo "Создайте виртуальный раздел"
    echo "Напишите: ./create_part <size part in Mb>"
    exit 1
fi

#монтируем раздел к промежуточной папке, затем добавляем папку пользователя

date_time_m=$(date +"%Y-%m-%d_%H-%M-%S") 
mkdir middle_dir_$date_time_m
sudo mount $vir_part middle_dir_$date_time_m 1> /dev/null 2> /dev/null
sudo mv $path_dir* middle_dir_$date_time_m
name_dir=$(basename $path_dir)
path_without_name=$(dirname $path_dir)
echo "Раздел успешно смонтирован"
echo "Путь к вашей папке изменился это необходимо для подсчета заполненности папки относительно раздела"
echo "Путь к вашей папке:" ./middle_dir_$date_time_m/$name_dir

#вычисляем заполненность папки

percent_of_fullness=$(df ./middle_dir_$date_time_m/$name_dir | tail -1 | awk '{print$5}' | sed 's/%//')

#проверяем нужно ли архивировать
 
echo "Папка заполнена на "$percent_of_fullness"%"
if [ $percent_of_fullness -le $fullness_X ]
then
    echo "Нормальный размер папки"
    sudo mv ./middle_dir_$date_time_m/$name_dir* $path_without_name/
    sudo umount ./middle_dir_$date_time_m
    sudo rm -r ./middle_dir_$date_time_m
    sudo rm $(ls -t virtual_part_*.img 2> /dev/null | head -1) 
    exit 1
fi

#находим N files

N_files=$(ls -t ./middle_dir_$date_time_m/$name_dir | tail --lines=$N)
#архивируем
 
tar -czf $path_backup/backupf$(date +"%Y-%m-%d_%H-%M-%S").tar.gz -C ./middle_dir_$date_time_m/$name_dir  $N_files
echo N_files "заархивированы"
echo "Архив можете посмотреть в папке" $path_backup
#удаляем из заданного директория
 
cd ./middle_dir_$date_time_m/$name_dir
rm $N_files
cd ~ 


sudo mv middle_dir_$date_time_m/$name_dir* $path_without_name/
sudo umount middle_dir_$date_time_m
sudo rm -r middle_dir_$date_time_m
sudo rm $(ls -t virtual_part_*.img 2> /dev/null | head -1) 
