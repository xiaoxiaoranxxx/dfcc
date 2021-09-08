# CloundDrive

````
CloudDriveService.exe

127.0.0.1:9798
````



## 端口占用

```
netstat  -aon|findstr  "9798"
taskkill -PID 4364 -F
```



## 打开脚本

```bat
@echo off 
 
if "%1" == "h" goto begin 
 
mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit 
 
:begin
CloudDriveService.exe

```

