#  Bugku where is flag

下载完成后为一个压缩包文件file.rar，将其解压后获得Key.rar和出师表.rar，

​	解压Key.rar获得13个txt结尾的文档，里面为《出师表》

​	解压出师表.rar时有密码无法解压。



**每个文档的中文字数不一样，有的有英文字母来填充**

​	每个文档的字数不一样会对文档的大小产生影响，而有的文档最后之所有有大写字母来填充，那么就是为了凑文档大小的数字！！！

​      

## 利用文件压缩前后的大小

```
75 101 121 58 90 104 117 71 76 64 64 46 48
```

## 脚本

```python
data =" 75 101 121 58 90 104 117 71 76 64 64 46 48 "
data=data.split()
# print(data)
for i in data:
    print(chr(int(i)),end='')
```

##得到密码

```
Key:ZhuGL@@.0
```

## 解压后获得一张图片

使用ctrl+f搜索flag

```
 flag in here {LjFWBuxFNTzEWv6t2NfxjNFSH1sQEwBt5wTTLD1fJ}
```

​	**base58**:编码去掉了几个看起来会产生歧义的字符

如 0 (零), O (大写字母O), I (大写的字母i) and l (小写的字母L) ，和几个影响双击选择的字符，

如/, +结果字符集正好58个字符(包括9个数字，24个大写字母，25个小写字母)。

[base58](http://www.metools.info/code/c74.html)

```
bugku{th1s_1s_chu_Sh1_B1A0!!@}
```



