      
`https://blog.csdn.net/zhang_yu_ling/article/details/103777714`
    
```
f<字母>	向后搜索<字母>并跳转到第一个匹配的位置
F<字母>	向前搜索<字母>并跳转到第一个匹配的位置

shift+zz	退出vim,保存

r 替换一个字符

gg 首行 / G末尾  3gg

x	删除游标所在的字符 /	3x	删除3个连续字符，以此类推 

dd	删除整行  /	2dd	向下删除2行，以此类推  相当剪贴

d 左右删 D

/string 查找  n/N切换   :noh 去除高亮

yy 复制 2yy

p	粘贴至光标后

u(n)	撤销一次或n次操作

>>	整行向右缩进
	
ctrl + v  块  I  ## esc  多行注释
	
:!ifconfig 直接调命令

:x	保存并退出vim
:wq	保存并退出vim
:set nu	显示行号

Ctrl+o	快速回到上一次（跳转前）光标所在位置

:1,3 s/docker/xiaoxiaoran 替换
:1,3 s/docker/xiaoxiaoran/g 全部替换
:%   s/docker/xiaoxiaoran/i 大小写 

cd ~  vim .vimrc

vim -o/O xiao2.txt xiao.txt   ctrl+w  :qa

vimdiff xiao1 xiao2
	
```