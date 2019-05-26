#!/bin/bash

# Desc: convert gfwlist.txt into dnsmasq.conf
# Dependency: base64, curl(https support), perl5 v5.10.0+
# Usage: bash gfwlist2dnsmasq [-s <addr>] [-p <port>] [-n <name>] [-l]
#        -s <addr>  dns server addr for resolve gfwlist domain. (default: 127.0.0.1)
#        -p <port>  dns server port for resolve gfwlist domain. (default: 60053)
#        -n <name>  which ipset will be saved the IP. (resolved from gfwlist domain)
#                   if this option is not set, the ipset rule will not be generated.
#        -l         generate gfwlist domain list instead of dnsmasq conf.
#                   if this option is set, other options will be ignored.
#        -h         show this help and exit.

# check dependency
command -v curl &>/dev/null || { echo "curl is not installed in this system" 1>&2; exit 1; }
command -v perl &>/dev/null || { echo "perl is not installed in this system" 1>&2; exit 1; }
command -v base64 &>/dev/null || { echo "base64 is not installed in this system" 1>&2; exit 1; }

# parse command line
while getopts ":s:p:n:lh" OPT; do
    case $OPT in
        s) dns_addr="$OPTARG";;
        n) set_name="$OPTARG";;
        l) dom_list="true";;
        h) cat << EOF
Usage: bash gfwlist2dnsmasq [-s <addr>] [-p <port>] [-n <name>] [-l]
 -s <addr>  dns server addr for resolve gfwlist domain. (default: 127.0.0.1)
 -h         show this help and exit.
EOF
exit;;
        :)  echo "Missing argument to '-$OPTARG'" 1>&2; exit 1;;
        \?) echo "Unknown option '-$OPTARG'" 1>&2;;
    esac
done

# temporary file
test -z "$dom_list" && temporary_file=$(mktemp) || temporary_file='domain_list.txt'

# convert gfwlist.txt
base64 -d       </dev/null &>/dev/null && base64='base64 -d'
base64 --decode </dev/null &>/dev/null && base64='base64 --decode'
[ "$base64" ] || { echo "[ERR] Command not found: 'base64'" 1>&2; exit 1; }
curl -4sSkL https://raw.github.com/gfwlist/gfwlist/master/gfwlist.txt | $base64 | { perl -pe '
if (/URL Keywords/i) { $null = <> until $null =~ /^!/ }
s#^\s*+$|^!.*+$|^@@.*+$|^\[AutoProxy.*+$|^/.*/$##i;
s@^\|\|?|\|$@@;
s@^https?:/?/?@@i;
s@(?:/|%).*+$@@;
s@\*[^.*]++$@\n@;
s@^.*?\*[^.]*+(?=[^*]+$)@@;
s@^\*?\.|^.*\.\*?$@@;
s@(?=[^0-9a-zA-Z.-]).*+$@@;
s@^\d+\.\d+\.\d+\.\d+(?::\d+)?$@@;
s@^\s*+$@@'
echo 'twimg.edgesuite.net'
echo -e 'blogspot.ae\nblogspot.al\nblogspot.am\nblogspot.ba\nblogspot.be\nblogspot.bg\nblogspot.bj\nblogspot.ca\nblogspot.cat\nblogspot.cf\nblogspot.ch\nblogspot.cl\nblogspot.co.at\nblogspot.co.id\nblogspot.co.il\nblogspot.co.ke\nblogspot.com\nblogspot.com.ar\nblogspot.com.au\nblogspot.com.br\nblogspot.com.by\nblogspot.com.co\nblogspot.com.cy\nblogspot.com.ee\nblogspot.com.eg\nblogspot.com.es\nblogspot.com.mt\nblogspot.com.ng\nblogspot.com.tr\nblogspot.com.uy\nblogspot.co.nz\nblogspot.co.uk\nblogspot.co.za\nblogspot.cv\nblogspot.cz\nblogspot.de\nblogspot.dk\nblogspot.fi\nblogspot.fr\nblogspot.gr\nblogspot.hk\nblogspot.hr\nblogspot.hu\nblogspot.ie\nblogspot.in\nblogspot.is\nblogspot.it\nblogspot.jp\nblogspot.kr\nblogspot.li\nblogspot.lt\nblogspot.lu\nblogspot.md\nblogspot.mk\nblogspot.mr\nblogspot.mx\nblogspot.my\nblogspot.nl\nblogspot.no\nblogspot.pe\nblogspot.pt\nblogspot.qa\nblogspot.re\nblogspot.ro\nblogspot.rs\nblogspot.ru\nblogspot.se\nblogspot.sg\nblogspot.si\nblogspot.sk\nblogspot.sn\nblogspot.td\nblogspot.tw\nblogspot.ug\nblogspot.vn'
echo -e 'google.ac\ngoogle.ad\ngoogle.ae\ngoogle.al\ngoogle.am\ngoogle.as\ngoogle.at\ngoogle.az\ngoogle.ba\ngoogle.be\ngoogle.bf\ngoogle.bg\ngoogle.bi\ngoogle.bj\ngoogle.bs\ngoogle.bt\ngoogle.by\ngoogle.ca\ngoogle.cat\ngoogle.cc\ngoogle.cd\ngoogle.cf\ngoogle.cg\ngoogle.ch\ngoogle.ci\ngoogle.cl\ngoogle.cm\ngoogle.cn\ngoogle.co.ao\ngoogle.co.bw\ngoogle.co.ck\ngoogle.co.cr\ngoogle.co.id\ngoogle.co.il\ngoogle.co.in\ngoogle.co.jp\ngoogle.co.ke\ngoogle.co.kr\ngoogle.co.ls\ngoogle.com\ngoogle.co.ma\ngoogle.com.af\ngoogle.com.ag\ngoogle.com.ai\ngoogle.com.ar\ngoogle.com.au\ngoogle.com.bd\ngoogle.com.bh\ngoogle.com.bn\ngoogle.com.bo\ngoogle.com.br\ngoogle.com.bz\ngoogle.com.co\ngoogle.com.cu\ngoogle.com.cy\ngoogle.com.do\ngoogle.com.ec\ngoogle.com.eg\ngoogle.com.et\ngoogle.com.fj\ngoogle.com.gh\ngoogle.com.gi\ngoogle.com.gt\ngoogle.com.hk\ngoogle.com.jm\ngoogle.com.kh\ngoogle.com.kw\ngoogle.com.lb\ngoogle.com.lc\ngoogle.com.ly\ngoogle.com.mm\ngoogle.com.mt\ngoogle.com.mx\ngoogle.com.my\ngoogle.com.na\ngoogle.com.nf\ngoogle.com.ng\ngoogle.com.ni\ngoogle.com.np\ngoogle.com.om\ngoogle.com.pa\ngoogle.com.pe\ngoogle.com.pg\ngoogle.com.ph\ngoogle.com.pk\ngoogle.com.pr\ngoogle.com.py\ngoogle.com.qa\ngoogle.com.sa\ngoogle.com.sb\ngoogle.com.sg\ngoogle.com.sl\ngoogle.com.sv\ngoogle.com.tj\ngoogle.com.tr\ngoogle.com.tw\ngoogle.com.ua\ngoogle.com.uy\ngoogle.com.vc\ngoogle.com.vn\ngoogle.co.mz\ngoogle.co.nz\ngoogle.co.th\ngoogle.co.tz\ngoogle.co.ug\ngoogle.co.uk\ngoogle.co.uz\ngoogle.co.ve\ngoogle.co.vi\ngoogle.co.za\ngoogle.co.zm\ngoogle.co.zw\ngoogle.cv\ngoogle.cz\ngoogle.de\ngoogle.dj\ngoogle.dk\ngoogle.dm\ngoogle.dz\ngoogle.ee\ngoogle.es\ngoogle.fi\ngoogle.fm\ngoogle.fr\ngoogle.ga\ngoogle.ge\ngoogle.gf\ngoogle.gg\ngoogle.gl\ngoogle.gm\ngoogle.gp\ngoogle.gr\ngoogle.gy\ngoogle.hn\ngoogle.hr\ngoogle.ht\ngoogle.hu\ngoogle.ie\ngoogle.im\ngoogle.io\ngoogle.iq\ngoogle.is\ngoogle.it\ngoogle.je\ngoogle.jo\ngoogle.kg\ngoogle.ki\ngoogle.kz\ngoogle.la\ngoogle.li\ngoogle.lk\ngoogle.lt\ngoogle.lu\ngoogle.lv\ngoogle.md\ngoogle.me\ngoogle.mg\ngoogle.mk\ngoogle.ml\ngoogle.mn\ngoogle.ms\ngoogle.mu\ngoogle.mv\ngoogle.mw\ngoogle.ne\ngoogle.net\ngoogle.nl\ngoogle.no\ngoogle.nr\ngoogle.nu\ngoogle.org\ngoogle.pl\ngoogle.pn\ngoogle.ps\ngoogle.pt\ngoogle.ro\ngoogle.rs\ngoogle.ru\ngoogle.rw\ngoogle.sc\ngoogle.se\ngoogle.sh\ngoogle.si\ngoogle.sk\ngoogle.sm\ngoogle.sn\ngoogle.so\ngoogle.sr\ngoogle.st\ngoogle.td\ngoogle.tg\ngoogle.tk\ngoogle.tl\ngoogle.tm\ngoogle.tn\ngoogle.to\ngoogle.tt\ngoogle.vg\ngoogle.vu\ngoogle.ws'; } | sort | uniq -i >${temporary_file}

# generated file type
    echo "type: domain_lists      file: ${temporary_file}"
    test -z "$dns_addr" && dns_addr='127.0.0.1:5533'
    #echo "# Generated by gfwlist2adguardhome at $(date '+%F %T')" >adguardhome_gfwlist.txt
    perl -pe "s@^.*+\$@[/$&/]$dns_addr@" ${temporary_file} >>adguardhome_gfwlist.txt
    rm -fr ${temporary_file}
    echo "type: adguardhome_server    file: adguardhome_gfwlist.txt"
