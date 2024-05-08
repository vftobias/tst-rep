#!/bin/bash
echo "Добро пожаловать в записную книжку Вована! "
if ! [ -f base.txt ]; then
  echo "База данных">base.txt
fi

  while true ;do
echo "
  Выберите номер:
1 - Добавить нового пользователя 
2 - Показать базу постояльцев
3 - Поиск по базе 
4 - Редактирование данных постояльца
5 - Удаление данных о постояльце
6 - Создай бэкап приложения с текущей датой
7 - Выйти из приложения"

read -p "Выберите номер действия:  " command 
case $command  in
 1)
    read -p "Выберите номер комнаты : " roomn
    read -p "Запишите свое Имя и Фамилию : " fio
    read -p "Запишите дату заезда :" start
    read -p "Запишите дату отъезда :" end

    echo "
Проверьте правильность данных:
    Номер вашей комнаты: $roomn 
    Ваши Имя и фамилия: $fio 
    Дата заезда: $start 
    Дата отъезда: $end " 
  rownumber=$(wc -l base.txt | awk '{print $1}';)
    echo "№$rownumber $roomn $fio $start $end " >> base.txt
    echo -e "\n  Запись добавлена" ;;
 2)

    cat base.txt ;;

 3)
    read -p "Поиск по базе :" find
    echo "Вот постояльцы с запрашиваемой вами информацией:"
    cat base.txt | grep $find ;;
 4)
    echo "Какие данные вы хотите изменить?"
    read -p "Что меняем " oldtext
    grep $oldtext base.txt
    read -p "Какую строку меняем? " oldline
    oldline="№${oldline}"
    echo "Меняем строчку $oldline"
    oldtext=$(grep "$oldline" base.txt)
    echo $oldtext

    read -p "Выберите номер комнаты : " roomn
    read -p "Запишите свое Имя и Фамилию : " fio
    read -p "Запишите дату заезда :" start
    read -p "Запишите дату отъезда :" end

    echo "
Проверьте правильность данных:
    Номер вашей комнаты: $roomn 
    Ваши Имя и фамилия: $fio 
    Дата заезда: $start 
    Дата отъезда: $end " 
    newtext="${oldline} ${roomn} ${fio} ${start} ${end}"

    echo $newtext

    sed "s/${oldtext}/${newtext}/" base.txt
    ;;
 5) 
    cat base.txt
    echo ""
    read -p "Какую строку удаляем? " oldline 
    oldline="№${oldline}"
    oldtext=$(grep "$oldline" base.txt)

    newtext="${oldline} удалено $(date +"%Y-%m-%d-%H-%M-%S")"
    echo $newtext
    sed -i "s/${oldtext}/${newtext}/" base.txt
    echo -e "\n"
    cat base.txt

    ;;
6) 
mkdir -p backup
cp base.txt backup/base-$(date +"%Y-%m-%d-%H-%M-%S").txt
ls backup ;;

7)
echo "До свидания"
break ;;



 *) 
    echo "Введите данные верно!"

esac
  done
