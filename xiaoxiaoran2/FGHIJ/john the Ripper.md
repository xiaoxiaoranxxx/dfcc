# John the Ripper是一个快速的密码破解程序

目前可用于Unix，Windows，DOS和OpenVMS的许多口味。
其主要目的是检测弱Unix密码。除了在各种Unix系统上最常见的几种crypt（3）密码哈希类型之外，
现在支持的还有Windows LM哈希，以及社区增强版本中的大量其他哈希和密码。







--single[=SECTION] ]“单裂”模式

--wordlist[=FILE] --stdin  单词表模式，从FILE或stdin读取单词

--pipe 像--stdin一样，但批量读取，并允许规则

--loopback[=FILE] 像 --wordlistg一样, 但是从.pot文件中获取单词

--dupe-suppression 压制wordlist中的所有模糊（并强制预加载）

--prince[=FILE] PRINCE模式，从FILE中读取单词

--encoding=NAME 输入编码（例如，UTF-8，ISO-8859-1）。 也可以看看doc / ENCODING和--list = hidden-options。

--rules[=SECTION] 为单词表模式启用单词修改规则

--incremental[=MODE] “增量”模式[使用部分模式]

--mask=MASK 掩码模式使用MASK

--markov[=OPTIONS] “马尔可夫”模式（参见doc / MARKOV）

--external=MODE 外部模式或字过滤器

--stdout[=LENGTH] 只是输出候选人密码[在LENGTH切]

--restore[=NAME] 恢复被中断的会话[名为NAME]

--session=NAME 给一个新的会话NAME

--status[=NAME] 打印会话的状态[名称]

--make-charset=FILE 制作一个字符集文件。 它将被覆盖

--show[=LEFT] 显示破解的密码[如果=左，然后uncracked]

--test[=TIME] 运行测试和每个TIME秒的基准

--users=[-]LOGIN|UID[,..] [不]只加载这个（这些）用户

--groups=[-]GID[,..] 只加载这个（这些）组的用户

--shells=[-]SHELL[,..] 用[out]这个（这些）shell来加载用户

--salts=[-]COUNT[:MAX] 用[out] COUNT [到MAX]散列加载盐

--save-memory=LEVEL 启用内存保存，级别1..3

--node=MIN[-MAX]/TOTAL 此节点的数量范围不在总计数中

--fork=N 叉N过程

--pot=NAME 锅文件使用

--list=WHAT 列表功能，请参阅--list = help或doc / OPTIONS

--format=NAME 强制使用NAME类型的散列。 支持的格式可以用--list=formats和--list=subformats来看


Usage: john [OPTIONS] [PASSWORD-FILES]
--single[=SECTION[,..]]    "single crack" mode, using default or named rules
--single=:rule[,..]        same, using "immediate" rule(s)
--wordlist[=FILE] --stdin  wordlist mode, read words from FILE or stdin
                  --pipe   like --stdin, but bulk reads, and allows rules
--loopback[=FILE]          like --wordlist, but extract words from a .pot file
--dupe-suppression         suppress all dupes in wordlist (and force preload)
--prince[=FILE]            PRINCE mode, read words from FILE
--encoding=NAME            input encoding (eg. UTF-8, ISO-8859-1). See also
                           doc/ENCODINGS and --list=hidden-options.
--rules[=SECTION[,..]]     enable word mangling rules (for wordlist or PRINCE
                           modes), using default or named rules
--rules=:rule[;..]]        same, using "immediate" rule(s)
--rules-stack=SECTION[,..] stacked rules, applied after regular rules or to
                           modes that otherwise don't support rules
--rules-stack=:rule[;..]   same, using "immediate" rule(s)
--incremental[=MODE]       "incremental" mode [using section MODE]
--mask[=MASK]              mask mode using MASK (or default from john.conf)
--markov[=OPTIONS]         "Markov" mode (see doc/MARKOV)
--external=MODE            external mode or word filter
--subsets[=CHARSET]        "subsets" mode (see doc/SUBSETS)
--stdout[=LENGTH]          just output candidate passwords [cut at LENGTH]
--restore[=NAME]           restore an interrupted session [called NAME]
--session=NAME             give a new session the NAME
--status[=NAME]            print status of a session [called NAME]
--make-charset=FILE        make a charset file. It will be overwritten
--show[=left]              show cracked passwords [if =left, then uncracked]
--test[=TIME]              run tests and benchmarks for TIME seconds each
--users=[-]LOGIN|UID[,..]  [do not] load this (these) user(s) only
--groups=[-]GID[,..]       load users [not] of this (these) group(s) only
--shells=[-]SHELL[,..]     load users with[out] this (these) shell(s) only
--salts=[-]COUNT[:MAX]     load salts with[out] COUNT [to MAX] hashes
--costs=[-]C[:M][,...]     load salts with[out] cost value Cn [to Mn]. For
                           tunable cost parameters, see doc/OPTIONS
--save-memory=LEVEL        enable memory saving, at LEVEL 1..3
--node=MIN[-MAX]/TOTAL     this node's number range out of TOTAL count
--fork=N                   fork N processes
--pot=NAME                 pot file to use
--list=WHAT                list capabilities, see --list=help or doc/OPTIONS
--format=NAME              force hash of type NAME. The supported formats can
                           be seen with --list=formats and --list=subformats
