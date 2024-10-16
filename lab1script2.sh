#!/bin/bash
LANG="ru_RU.UTF-8"

ls ./backup 2> /dev/null 1> /dev/null 
if [ "$?" -ne 0 ]
then 
   mkdir backup
fi
mkdir log1 log2 log3 log4 log5 log6
dir_backup="./backup"
dir_log_1="./log1"
dir_log_2="./log2"
dir_log_3="./log3"
dir_log_4="./log4"
dir_log_5="./log5"
dir_log_6="./log6"
echo "Тест 1"
echo
./create_part.sh 50 #раздел 50М
cd "$dir_log_1"
for i in {1..10}
do
   touch file$i
   chmod a+x file$i
   dd if=/dev/zero of=file$i bs=1M count=2 2> /dev/null 1> /dev/null
done
cd ~
./lab1script1.sh "$dir_log_1" 60 3 "$dir_backup"
echo

echo "Тест 2"
echo
./create_part.sh 25 
cd "$dir_log_2"
for i in {1..5}
do
   touch test2$i
   chmod a+x test2$i
   dd if=/dev/zero of=test2$i bs=1M count=1 2>/dev/null 1> /dev/null
   sleep 0.1
done
cd ~
./lab1script1.sh "$dir_log_2" 15  10 "$dir_backup"
echo

echo "Тест 3"
echo
./create_part.sh 49
cd "$dir_log_3"
for i in {1..7}
do
   touch test3$i
   chmod a+x test3$i
   dd if=/dev/zero of=test3$i bs=1M count=4 2>/dev/null 1> /dev/null
   sleep 0.1
done
cd ~
./lab1script1.sh "$dir_log_3" 80  3 "$dir_backup"
echo

echo "Тест 4"
echo
./create_part.sh 100
cd "$dir_log_4"
for i in {1..7}
do
   touch test4$i
   chmod a+x test4$i
   dd if=/dev/zero of=test4$i bs=1M count=10 2>/dev/null 1> /dev/null
   sleep 0.1
done
cd ~
./lab1script1.sh "$dir_log_4" 40  3 "$dir_backup"
echo

echo "Тест 5"
echo
./create_part.sh l
cd "$dir_log_5"
for i in {1..5}
do
   touch test5$i
   chmod a+x test5$i
   dd if=/dev/zero of=test5$i bs=1M count=1 2>/dev/null 1> /dev/null
   sleep 0.1
done
cd ~
./lab1script1.sh "$dir_log_5" 15  10 "$dir_backup"
echo

echo "Тест 6"
echo
./create_part.sh 72
cd "$dir_log_6"
for i in {1..20}
do
   touch test6$i
   chmod a+x test6$i
   dd if=/dev/zero of=test6$i bs=1M count=2 2>/dev/null 1> /dev/null
   sleep 0.1
done
cd ~
./lab1script1.sh "$dir_log_6" 60  15 "$dir_backup"
echo
rm -r log*

