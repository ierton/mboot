Здесь описана процедура сборки и записи U-boot в NAND память УЭМД и его
настройка для автоматической загрузки при включении питания.

U-Boot 
======

Для прошивки U-boot в УЭМД, необходим файл u-boot.bin. Его можно либо взять
готовым, либо собирать из исходников.

Использование готового образа
-----------------------------

* Скачать и распаковать нужный архив с бинарниками из git-репозитория. Какой
именно архив был загружен последним можно определить, посмотрев последние записи
в логе. 

* Открыть терминал, перейти в распакованную директорию и запустить скрипт 

	./rungdb

При необходимости, можно явно указать IP отладчика и программу GDB c помощью
параметров (см. ./rungdb --help).

Сборка Mboot из исходников
---------------------------

Для сборки загрузчика необходимо:

* Настроить компилятор arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2008q3-72) 4.3.2. 
Допустим, он установлен в системе в папку /opt/codesourcery-200x/

* Получить исходники Mboot из системы контроля версий, выполнив команду

	$ git clone boarduser@194.190.196.141:/home/gitpub/mboot && cd mboot

* Настроить переменную окружения CROSS_COMPILE:

	export CROSS_COMPILE="/opt/codesourcery-200x/bin/arm-none-linux-gnueabi-"

* Выполнить команду make, указав Makefile, соответствующей требуемой
  архитектуре. Для сборки загрузчика под UEMD необходимо выполнить:

 	$ make -f Makefile.uemd

Признак успешной компиляции - наличие файла mboot-uemd.bin в текущей директории.

* Для загрузки образа можно использовать скрипт ./rungdb

	$ export CROSS_COMPILE=/opt/codesourcery-200x/bin/arm-none-linux-gnueabi-
	$ ./rungdb -i <GDB_SERVER>

* В открывшейся консоли gdb дать команду на исполнеие программы.

	gdb> cont
