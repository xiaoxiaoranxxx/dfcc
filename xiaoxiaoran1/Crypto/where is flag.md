# BugkuCTF-MISC题where is flag

## 解压得到10个txt文件

## 010打开发现里面全是00截断符号

![image-20210920151020589](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201510107.png)

```
for n in range(1, 11):
    name = str(n)+'.txt'
    with open(name) as f:
        print(len(f.read()), end=" ")

```

```
flag = '98 117 103 107 117 123 110 97 48 100 48 110 103 100 97 107 97 49 125'
flag = flag.split(' ')
for i in flag:
    print(chr(int(i)), end="")

```

