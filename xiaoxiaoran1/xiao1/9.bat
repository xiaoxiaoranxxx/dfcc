@echo off

echo 1.a
echo 2.a
echo 3.a
echo 4.a

:first

echo enter your option:

set /p opt=
if %opt%==1 goto one
if %opt%==2 goto two
:: if %opt%==3 goto three
:: if %opt%==4 goto four
echo false option
goto first

:one
echo your choice one
pause>nul
exit
:two
echo your choice two
pause>nul
exit


