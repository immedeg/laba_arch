Лабораторная работа по дисциплине "Архитектура ПК и ОС" №1

Описание лабораторной работы: проект включает в себя 3 -shell скрипта для Unix-подобной системы

Описание скриптов:
1) create_part.sh
   Этот скрипт создает виртуальный раздел на диске (размер задаётся).
   Сначала производится проверка аргументов: необходим один аргумент в Мб, если переданное значение не является числом, то выводится ошибка.
   Далее создается виртуальный диск (имя файла для виртуального раздела формируется с текущей датой и временем).
   С помощью команды dd файл заполняется нулями.
   Далее формируется файловая система с помощью mkfs.ext4
2) lab1script1.sh
   Сначала производится проверка аргументов, существования директорий и того, что параметры N и X находятся в диапазоне от 0 до 100.
   Далее после поиска виртуального раздела происходит его монтирование.
   Потом скрипт вычисляет процент заполненности и сравнивает со значением X.
   Если заполненность превышает X процентов, то происходит архивация последних N файлов (после архивации файлы удаляются из временной директории)
3) lab1script2.sh
   Проверка существования директории backup (если её нет, то он её создает).
   Создание директорий log1 - log6.
   Для каждой директории:
     создание раздела с помощью create_part.sh
     генерация файлов, заполненных нулями
     вызов lab1script1.sh
   Скрипт необходим для генерации тестов
   