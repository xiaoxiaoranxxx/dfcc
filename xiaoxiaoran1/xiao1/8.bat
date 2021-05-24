@echo off

:: for /d %%a in (*) do echo %%a

:: for /d %%a in (*) do if %%a==test rd %%a

:: for /r %%a in (*) do echo %%a

for /l %%a in (1,5,99) do ping %1.%%a
rem 8.bat 192.168.100

pause