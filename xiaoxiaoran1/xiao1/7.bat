:: tracert baidu.com
@echo off


set v=hello

if %v%==hello (echo ok) else (echo no)

if exist 1.bat (echo ok) else (echo no)


if exist 1.txt (
	echo file is find!
	del 1.txt
) else (
	echo file not find
)


pause 
