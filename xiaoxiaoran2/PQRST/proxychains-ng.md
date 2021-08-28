

	https://www.fujieace.com/kali-linux/proxychains.html


`proxychains4 curl ip.sb      `

```
dynamic_chain：该配置项能够通过ProxyList中的每个代理运行流量，如果其中一个代理关闭或者没有响应，它能够自动选择ProxyList中的下一个代理；
strict_chain：改配置为ProxyChains的默认配置，不同于dynamic_chain，也能够通过ProxyList中的每个代理运行流量，但是如果ProxyList中的代理出现故障，不会自动切换到下一个。
random_chain：该配置项会从ProxyList中随机选择代理IP来运行流量，如果ProxyList中有多个代理IP，在使用proxychains的时候会使用不同的代理访问目标主机，从而使主机端探测流量更加困难。

```


