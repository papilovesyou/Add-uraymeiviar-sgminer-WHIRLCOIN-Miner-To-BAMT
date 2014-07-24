#!/bin/sh
mine stop
sleep 5
git clone https://github.com/uraymeiviar/sgminer sgminer-whirlcoin
cd /opt/miners/sgminer-whirlcoin
cp /opt/miners/sgminer-4.1.0-sph/ADL_SDK/* /opt/miners/sgminer-whirlcoin/ADL_SDK/
make clean
sleep 5
chmod +x autogen.sh
./autogen.sh
sleep 2
autoreconf -i CFLAGS="-O2 -Wall -march=native" ./configure <options> 
make
sleep 5
make install
sleep 5
clear
cp example.conf /etc/bamt/uraymeiviar-whirlcoin.conf
cd /etc/bamt/
patch /etc/bamt/bamt.conf <<.
116a117
>   cgminer_opts: --api-listen --config /etc/bamt/uraymeiviar-whirlcoin.conf
124a127
>   # uraymeiviar WHIRLCOIN Whirlcoin "WHRL"
129a133
>   miner-uraymeiviar-whirlcoin: 1
.
patch /opt/bamt/common.pl <<.
1477a1478,1480
>       } elsif (\${\$conf}{'settings'}{'miner-uraymeiviar-whirlcoin'}) {
>         \$cmd = "cd /opt/miners/sgminer-whirlcoin/;/usr/bin/screen -d -m -S sgminer-whirl /opt/miners/sgminer-whirlcoin/sgminer \$args";
>         \$miner = "sgminer-whirl";
.
cd /etc/bamt/
patch /etc/bamt/uraymeiviar-whirlcoin.conf <<.
22c22
< "kernel" : "ckolivas,ckolivas,ckolivas",
---
> "kernel" : "whirlcoin",
37,39c37,39
< "api-listen" : false,
< "api-mcast-port" : "4028",
< "api-port" : "4028",
---
> "api-listen": true,
> "api-port": "4028",
> "api-allow": "W:127.0.0.1",
> 
.
echo 'uraymeiviar Miner Installed.'
echo 'Please review your /etc/bamt/bamt.conf to enable.'
echo 'Configure /etc/bamt/uraymeiviar-whirlcoin.conf with pool'
