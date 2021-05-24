@echo off


:: start "xiaoxiaoran"

:: call 4.bat

:: tasklist /S 192.168.1.1 /u admin /p password 查看远程机器


:: start cmd

start notepad.exe

echo xiao

taskkill /f /t /im notepad.exe

:: 强制 子进程
:: taskkill /pid 15555 /T




pause