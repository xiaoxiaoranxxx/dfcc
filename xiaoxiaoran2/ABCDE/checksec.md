# checksec工具使用

<img src="https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210917231733128.png" alt="image-20210917231733128"  />



```sh
checksec  --file=filename
```



## Arch:

程序架构信息。判断是拖进64位IDA还是32位？exp编写时p64还是p32函数？

## RELRO

Relocation Read-Only (RELRO) 此项技术主要针对 GOT 改写的攻击方式。

它分为两种，Partial RELRO 和 Full RELRO。部分RELRO 易受到攻击，

例如攻击者可以**atoi.got为system.plt，进而输入/bin/sh\x00获得shell**
完全RELRO 使整个 GOT 只读，从而无法被覆盖，但这样会大大增加程序的启动时间

因为程序在启动之前需要解析所有的符号。

```bash
gcc -o hello test.c // 默认情况下，是Partial RELRO
gcc -z norelro -o hello test.c // 关闭，即No RELRO
gcc -z lazy -o hello test.c // 部分开启，即Partial RELRO
gcc -z now -o hello test.c // 全部开启，即Full RELRO
```

#### Stack-canary

栈溢出保护是一种缓冲区溢出攻击缓解手段，当函数存在缓冲区溢出攻击漏洞时，攻击者可以覆盖栈上的返回地址来让shellcode能够得到执行。当启用栈保护后，函数开始执行的时候会先往栈里插入类似cookie的信息，当函数真正返回的时候会验证cookie信息是否合法，如果不合法就停止程序运行。攻击者在覆盖返回地址的时候往往也会将cookie信息给覆盖掉，导致栈保护检查失败而阻止shellcode的执行。在Linux中我们将cookie信息称为canary。

```bash
gcc -fno-stack-protector -o hello test.c   //禁用栈保护
gcc -fstack-protector -o hello test.c    //启用堆栈保护，不过只为局部变量中含有 char 数组的函数插入保护代码
gcc -fstack-protector-all -o hello test.c  //启用堆栈保护，为所有函数插入保护代码
```

#### NX

NX enabled如果这个保护开启就是意味着栈中数据没有执行权限，如此一来, 当攻击者在堆栈上部署自己的 shellcode 并触发时, 只会直接造成程序的崩溃，但是可以利用rop这种方法绕过

```bash
gcc -o  hello test.c // 默认情况下，开启NX保护
gcc -z execstack -o  hello test.c // 禁用NX保护
gcc -z noexecstack -o  hello test.c // 开启NX保护
```

#### PIE

PIE(Position-Independent Executable, 位置无关可执行文件)技术与 ASLR 技术类似,ASLR 将程序运行时的堆栈以及共享库的加载地址随机化, 而 PIE 技术则在编译时将程序编译为位置无关, 即程序运行时各个段（如代码段等）加载的虚拟地址也是在装载时才确定。这就意味着, 在 PIE 和 ASLR 同时开启的情况下, 攻击者将对程序的内存布局一无所知, 传统的改写
GOT 表项的方法也难以进行, 因为攻击者不能获得程序的.got 段的虚地址。
若开启一般需在攻击时泄露地址信息

```bash
gcc -o hello test.c  // 默认情况下，不开启PIE
gcc -fpie -pie -o hello test.c  // 开启PIE，此时强度为1
gcc -fPIE -pie -o hello test.c  // 开启PIE，此时为最高强度2
(还与运行时系统ALSR设置有关）
```

#### RPATH/RUNPATH

程序运行时的环境变量，运行时所需要的共享库文件优先从该目录寻找，可以fake lib造成攻击


#### FORTIFY

这是一个由GCC实现的源码级别的保护机制，其功能是在编译的时候检查源码以避免潜在的缓冲区溢出等错误。
简单地说，加了这个保护之后,一些敏感函数如read, fgets,memcpy, printf等等可能
导致漏洞出现的函数都会被替换成__read_chk,__fgets_chk, __memcpy_chk, __printf_chk等。
这些带了chk的函数会检查读取/复制的字节长度是否超过缓冲区长度，

通过检查诸如%n之类的字符串位置是否位于可能被用户修改的可写地址，
避免了格式化字符串跳过某些参数（如直接%7$x）等方式来避免漏洞出现。
开启了FORTIFY保护的程序会被checksec检出，此外，在反汇编时直接查看got表也会发现chk函数的存在
这种检查是默认不开启的，可以通过

```bash
gcc -D_FORTIFY_SOURCE=2 -O1
开启fortity检查，开启后会替换strcpy等危险函数。
```