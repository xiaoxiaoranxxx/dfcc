# dycrypt

描述: fR4aHWwuFCYYVydFRxMqHhhCKBseH1dbFygrRxIWJ1UYFhotFjA=

```php
<?php
function encrypt($data,$key)
{
    $key = md5('ISCC');
    $x = 0;
    $len = strlen($data);
    $klen = strlen($key);
    for ($i=0; $i < $len; $i++) { 
        if ($x == $klen)
        {
            $x = 0;
        }
        $char .= $key[$x];
        $x+=1;
    }
    for ($i=0; $i < $len; $i++) {
        $str .= chr((ord($data[$i]) + ord($char[$i])) % 128);
    }
    return base64_encode($str);
}
?>
```

- 加密过程是把ISCC转换成一个md5值，
- 然后把每一位放在一个数组里，然后和待解的flag里面的每一位相加模128，
- 得到字符的ascii码，最后base64编码解密的话就反着来，
- 先base64解码，然后将结果每一位的ascii码值减去密钥的ascii码值，
- 注意ascii码值需要在0-128之间，所以需要加上1个128
- 然后再求模最后再转成字符，就得到flag

```python
# /usr/bin/python
import base64
def decrypt(str):
    text1=base64.b64decode(str)
    key='729623334f0aa2784a1599fd374c120d729623'
    flag=''
    for i in range(len(text1)):
       flag +=chr((text1[i]-ord(key[i])+128)%128)   
    print(flag)

if __name__ == '__main__':
    str='fR4aHWwuFCYYVydFRxMqHhhCKBseH1dbFygrRxIWJ1UYFhotFjA='
    decrypt(str)
```



```
Flag:{asdqwdfasfdawfefqwdqwdadwqadawd}
```

