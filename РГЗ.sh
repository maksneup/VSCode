#!/bin/sh
# $1 путь директории для удаления. $2 путь директории для копирования
if [ -d $1 ] # Проверка на существование директории для удаления
then echo "Директория для удаления найдена" 
else echo "Директория не найдена" ; exit
fi 
if [ -z $2 ] 
then echo "Директория для копирования/удаления не введена"; exit
fi
if [ -e $2 ] # Проверка на существование директории для копирования 
then echo "Директория для копирования найдена"
else 
read -p "Директория для копирования не найдена, создать директорию?(Y/N) " yn # Если директории для копирования не существует, то будет предложено создать её
 case $yn in # Оператор выбора
   [Yy] ) mkdir $2; echo "Копирование в $2" ; break ;; # Если введенный символ Y или y, то будет создана директория которую указал пользователь.
   [Nn] ) exit;; # Если введенный символ N или n скрипт завершится.
   * ) exit;; # Завершение скрипта если введенный символ не равен Y или N.
 esac
fi
i=0 # Приравниваем переменную i к 0
find $1 -type f | while read dell # Поиск файлов в директории и запись в переменную "dell"
do 
i=$(($i+1)); #Каждый "проход" прибавляет 1 к i
cd $2; 
cp $dell $i; 
done; 
rm -r $1  
exit 0

