# BUGKU-MISC-Cisco 



```
U2FsdGVkX19T7VS86emCFReuh2Tjc3ZtbB5HMHebPd8=
```

由观察可知，2.txt中的内容为某种对称加密法

[在线AES加密、AES解密工具](http://www.jsons.cn/aesencrypt/)

由在线解密工具解得：“文件后缀”

cisco为“思科”，题意为使用思科虚拟机来解题，结合1.1的hint，

**应该将1.txt改为1.pka**



点击中间的switch()，选择CLI，输入enable，意图获取特权，

继续输入密码flag（输入时可能不显示，但不要紧），

从而取得权限（没得到特权前，显示“switch>"，得到特权后，显示”switch#“），

再输入show running-config | include flag，就能得到flag