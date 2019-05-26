# gfwlist2AdGuardHome
转换gfwlist到AdGuardHome规则文件
脚本修改自https://github.com/zfl9/gfwlist2dnsmasq


## 脚本依赖
- base64
- curl (https)
- Perl5 v5.10.0+

## 脚本语法
- ./gfwlist2adguardhome.sh -s 8.8.8.8:53
- ./gfwlist2adguardhome.sh -s https://1.0.0.1/dns-query
- ./gfwlist2adguardhome.sh -s tls://1dot1dot1dot1.cloudflare-dns.com
- ./gfwlist2adguardhome.sh -s tcp://1.1.1.1
- ./gfwlist2adguardhome.sh -s tls://1dot1dot1dot1.cloudflare-dns.com
- ./gfwlist2adguardhome.sh -s sdns://AgcAAAAAAAAABzcuNy43LjcAAAovZG5zLXF1ZXJ5

