#  Go 语言编写的 Web 应用程序扫描器

它功能强大、灵活易扩展，堪称用于自动 Web 应用程序渗透测试的瑞士军刀。

其原理大致为，通过浏览器或者命令行工具使用 jaeles 扫描器，
获取Urls列表或原始请求，并与签名结合以生成请求。
发送这些请求并运行检测脚本以确定请求是否易受攻击。

GO111MODULE=on go get github.com/jaeles-project/jaeles

```
docker pull j3ssie/jaeles
```



```
docker run j3ssie/jaeles scan -s '<selector>' -u http://example.com

docker run j3ssie/jaeles scan -u baidu.com
```



Scan Usage example:
  jaeles scan -s <signature> -u <url>
  jaeles scan -c 50 -s <signature> -U <list_urls> -L <level-of-signatures>
  jaeles scan -c 50 -s <signature> -U <list_urls>
  jaeles scan -c 50 -s <signature> -U <list_urls> -p 'dest=xxx.burpcollaborator.net'
  jaeles scan -c 50 -s <signature> -U <list_urls> -f 'noti_slack "{{.vulnInfo}}"'
  jaeles scan -v -c 50 -s <signature> -U list_target.txt -o /tmp/output
  jaeles scan -s <signature> -s <another-selector> -u http://example.com
  echo '{"BaseURL":"https://example.com/sub/"}' | jaeles scan -s sign.yaml -J 
  jaeles scan -G -s <signature> -s <another-selector> -x <exclude-selector> -u http://example.com
  cat list_target.txt | jaeles scan -c 100 -s <signature>

Examples:
  jaeles scan -s 'jira' -s 'ruby' -u target.com
  jaeles scan -c 50 -s 'java' -x 'tomcat' -U list_of_urls.txt
  jaeles scan -G -c 50 -s '/tmp/custom-signature/.*' -U list_of_urls.txt
  jaeles scan -v -s '~/my-signatures/products/wordpress/.*' -u 'https://wp.example.com' -p 'root=[[.URL]]'
  cat urls.txt | grep 'interesting' | jaeles scan -L 5 -c 50 -s 'fuzz/.*' -U list_of_urls.txt --proxy http://127.0.0.1:8080



Usage:
  jaeles scan [flags]

Flags:
  -h, --help          help for scan
      --html          Generate HTML report after the scan done
  -r, --raw string    Raw request from Burp for origin
  -u, --url string    URL of target
  -U, --urls string   URLs file of target

Global Flags:
      --at                      Enable Always True Detection for observe response
      --ba                      Shortcut for -p 'BaseURL=[[.Raw]]' or -p 'root=[[.Raw]]'
      --chunk                   Enable chunk running against big input
      --chunk-dir string        Temp Directory to store chunk directory
      --chunk-limit int         Limit size to trigger chunk run (default 200000)
      --chunk-size int          Chunk Size (default 20000)
  -c, --concurrency int         Set the concurrency level (default 20)
      --config string           config file (default is $HOME/.jaeles/config.yaml)
      --debug                   Debug
      --delay int               Delay time between requests
  -x, --exclude strings         Exclude Signature selector (Multiple -x flags are accepted)
  -J, --format-input            Enable special input format
  -f, --found string            Run host OS command when vulnerable found
  -H, --headers strings         Custom headers (e.g: -H 'Referer: {{.BaseURL}}') (Multiple -H flags are accepted)
      --hh                      Show full help message
      --json                    Store output as JSON
      --lc                      Shortcut for '--proxy http://127.0.0.1:8080'
  -L, --level int               Filter signature by level (default 1)
  -l, --log string              log file
      --no-background           Do not run background task
      --no-db                   Disable Database
  -N, --no-output               Do not store output
  -o, --output string           Output folder name (default "out")
  -p, --params strings          Custom params -p='foo=bar' (Multiple -p flags are accepted)
  -G, --passive                 Turn on passive detections
      --passiveOutput string    Passive output folder (default is passive-out)
      --passiveSummary string   Passive Summary file
      --proxy string            proxy
  -q, --quiet                   Quiet Output
  -Q, --quietFormat string      Format for quiet output (default "{{.VulnURL}}")
      --refresh int             Refresh time for background task (default 10)
  -R, --report string           Report name
      --retry int               HTTP Retry
      --rootDir string          root Project (default "~/.jaeles/")
      --save-raw                save raw request
      --scanID string           Scan ID
  -S, --selectorFile string     Signature selector from file
  -B, --signDir string          Folder contain default signatures (default "~/.jaeles/base-signatures/")
  -s, --signs strings           Signature selector (Multiple -s flags are accepted)
      --single                  Disable parallel mode (use this when you need logic in single signature
      --sp string               Selector for passive detections (default "*")
  -O, --summaryOutput string    Summary output file
      --summaryVuln string      Summary output file
      --sverbose                Store verbose info in summary file
  -t, --threads int             Number of Threads (Only used in chunk mode) (default 1)
      --timeout int             HTTP timeout (default 20)
      --title string            Report title name
  -v, --verbose                 Verbose output
  -V, --version                 Print version of Jaeles

