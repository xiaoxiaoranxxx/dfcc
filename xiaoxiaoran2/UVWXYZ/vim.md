# vim 常用

## 设置vim的默认配置

```sh
cd ~  
vim .vimrc

写入 set nu         #默认显示行号
```

## 退出

```sh
shift+zz	快速退出vim并保存
:wq  保存并退出
:q! 强制退出,不保存
```

## 常用设置

```sh
:set nu	显示行号
:!ifconfig 直接调命令
>>	整行向右缩进
:noh 去除高亮
u(n)	撤销一次或n次操作
```

## 跳转

```sh
Ctrl+o	快速回到上一次（跳转前）光标所在位置
f<字母>	向后搜索<字母>并跳转到第一个匹配的位置
F<字母>	向前搜索<字母>并跳转到第一个匹配的位置
gg 快速回到首行 
G 快速回到末尾 
3gg  快速回到3行 
```

## 替换删除

```sh
r 替换一个字符
x	删除游标所在的字符 /
3x	删除3个连续字符

dd	删除整行  
2dd	向下删除2行

d + -> 左右删 
D 删除光标右侧的

:1,3 s/docker/xiaoxiaoran 替换1个"docker"->"xiaoxiaoran"个在1-3行
:1,3 s/docker/xiaoxiaoran/g 全部替换"docker"->"xiaoxiaoran"个在1-3行
```

## 复制粘贴

```sh
yy 复制一行
2yy 复制两行

p	粘贴至光标后
```

## 查找

```sh
/string 查找  n/N为上下切换   
```

