
## pydictor —— 一个强大实用的黑客暴力破解字典建立工具
```
git clone https://github.com/LandGrey/pydictor.git
```

### 数字3-4位
`python pydictor.py -base d --len 3 4`

### 数字字母保存
`python pydictor.py -base dLc --len 2 3 -o /root/xiao/1.txt`

### 以xiao开头
`python pydictor.py -base d --len 3 3 --head xiao`

### 去重合并
`python pydictor.py  -tool uniqbiner results/`


```
-base 基本类型
-char 字符型
-chunk 块
-extend 延伸
-plug 插件
--conf 基于配置文件的词汇表
-sedb 社会工程学
-o 指定生成的txt的文件路径
-tool 使用工具 如·:组合，比较器，计数器，处理器，uniqbiner，uniqifer
--len 长度范围
--head 添加头文件
--tail 添加尾部文件
--encode 加密功能模块
--occur 发生功能模块
--types 类型功能模块
--regex 正则表达式函数
--level 等级
--leet leet表
```

## md5匹配

### 使用
```
echo ZZZ|md5sum
python /root/md5.py 4d50db1dc6bd8d4f8dc1ca9b83bdc187 /root/1.txt
```

### md5.py源码
```python
# -*- coding:utf-8 -*-
import hashlib
import sys
def get_cmd5(md5str):

    m1 = hashlib.md5()
    m1.update(md5str.encode("utf-8"))
    result = m1.hexdigest()
    return result
def get_file_lines(filename):
    with open(filename) as f:
        line_list = f.readlines()
        return line_list
lines = get_file_lines((sys.argv[2]))
encode_str = (sys.argv[1])
for line in lines:
    if encode_str == get_cmd5(line):
        print("解密成功！密码是: "+line)
        break
    else:
        continue
```
