

`torbrowser-launcher          `
	
## 完成日志
```
Aug 07 12:37:08.601 [notice] Tor 0.4.5.9 running on Linux with Libevent 2.1.12-stable, OpenSSL 1.1.1k, Zlib 1.2.11, Liblzma 5.2.5, Libzstd 1.4.8 and Glibc 2.31 as libc.
Aug 07 12:37:08.601 [notice] Tor can't help you if you use it wrong! Learn how to be safe at https://www.torproject.org/download/download#warning
Aug 07 12:37:08.602 [notice] Read configuration file "/etc/tor/torrc".
Aug 07 12:37:08.605 [notice] Opening Socks listener on 127.0.0.1:9050
Aug 07 12:37:08.606 [notice] Opened Socks listener connection (ready) on 127.0.0.1:9050
Aug 07 12:37:08.000 [notice] Parsing GEOIP IPv4 file /usr/share/tor/geoip.
Aug 07 12:37:08.000 [notice] Parsing GEOIP IPv6 file /usr/share/tor/geoip6.
Aug 07 12:37:09.000 [notice] Bootstrapped 0% (starting): Starting
Aug 07 12:37:09.000 [notice] Starting with guard context "default"
Aug 07 12:37:10.000 [notice] Bootstrapped 5% (conn): Connecting to a relay
Aug 07 12:37:14.000 [notice] Bootstrapped 10% (conn_done): Connected to a relay
Aug 07 12:37:14.000 [notice] Bootstrapped 14% (handshake): Handshaking with a relay
Aug 07 12:37:15.000 [notice] Bootstrapped 15% (handshake_done): Handshake with a relay done
Aug 07 12:37:15.000 [notice] Bootstrapped 75% (enough_dirinfo): Loaded enough directory info to build circuits
Aug 07 12:37:15.000 [notice] Bootstrapped 90% (ap_handshake_done): Handshake finished with a relay to build circuits
Aug 07 12:37:15.000 [notice] Bootstrapped 95% (circuit_create): Establishing a Tor circuit
Aug 07 12:37:15.000 [notice] Bootstrapped 100% (done): Done
```

## 使用
```sh
proxychains4 curl ipinfo.io/ip        
                                               
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.14
[proxychains] Strict chain  ...  127.0.0.1:9050  ...  ipinfo.io:80  ...  OK
109.70.100.28         ```                                                                                     


