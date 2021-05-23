@echo off

:: net user /add admin 123456

echo %1
echo %2

net user %1 %2 /add

:: C:\Users\Administrator\Desktop>3.bat admin 123456

pause