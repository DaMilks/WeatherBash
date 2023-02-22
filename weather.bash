#!/bin/bash
clear
while :
do
echo; echo "
1)Вывести список метеостанций
2)Погода в каком городе интересует?
3)Введите синоптический индекс для получения информации о погоде."
read choose
case "$choose" in
  1   )echo Соединение........
lynx -dump http://meteomaps.ru/meteostation_codes.html|grep 'Российская'|awk '{print $1,$2}'|more;;
  2   )echo Город:
read city
echo Ищем........
lynx -dump http://meteomaps.ru/meteostation_codes.html|grep $city|awk '{print $1,$2}'
;;
  3   ) echo Введите индекс метеостанции
read index
echo Соединение........
testus=$(lynx -dump http://informer.gismeteo.ru/rss/$index.xml|sed -n '/<item>/,/<\/item>/p'|sed -n '/<title>.*<\/title>/p;/<description>.*<\/description>/p'| sed 's/<[^>]*>//g;s/\t\t*//g')
echo "${testus:=Станция не существует/не обслуживается gismeteo}";;
  *   ) echo "Нет такого варианта";;
esac
read -sn1 -p "Нажмите любую клавишу чтобы продолжить.."; echo 
clear
done