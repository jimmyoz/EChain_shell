#!/bin/bash
mv BlockServer.zip /data
cd /data
yum install unzip -y
unzip BlockServer.zip
cp BlockServer/lib/libstdc++.so.6.0.24 /usr/lib64/
cd /usr/lib64
mv libstdc++.so.6 libstdc++.so.6_bak
ln -s /usr/lib64/libstdc++.so.6.0.24 libstdc++.so.6
echo "export LD_LIBRARY_PATH=:/data/BlockServer/lib" >> ~/.bashrc
source ~/.bashrc
cd /data/BlockServer
./EChainServer
