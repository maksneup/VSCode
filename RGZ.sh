#!/bin/sh
echo -n "Введите путь для удаления: "; read dell # Ввод директории для удаления и запись в переменную dell
if [ -e $dell ] # Проверка существования пути для удаления
    then echo -n "Введите путь для копирования: " # Если путь для удаления существует, то пользователь вводит путь для дериктории в которую производить копирование
    else echo "Директория не найдена" ; exit
fi
read coppy # Запись пути для копирования в переменную coppy
if [ -e $coppy ]
    then echo "Копирование..."
    else echo -n "Директория для копирования не найдена, создать? (Д/Н):  " ; read reshenie; 
        case $reshenie in 
        [Дд] ) mkdir $coppy ; echo "Копирование..." ; break ;; 
        [Нн] ) exit;; 
        * ) exit ;; 
        esac 
fi
i=1
find $dell -type f | while read perebor; # Поиск файлов в директории для удаления и запись путей в переменную "perebor"
do # При каждом проходе открывается директория $coppy, в нее копируется файл из переменной "perebor" с изменением имени на i. 
    cd $coppy;
    cp $perebor $i;
    i=$(($i+1));
done
summ1=$(find $dell -type f | wc -l) # Проверка количества файлов до копирования
summ2=$(find $coppy -type f | wc -l) # Проверка количества файлов после копирования
if [ $summ1 -eq $summ2 ] # если количество файлов до и после копирования совпадают, то директория $dell будет удалена
    then echo "Копирование успешно" ; rm -r $dell
    else echo "Копирование не выполнено"; rm -r $coppy
fi 
exit 0