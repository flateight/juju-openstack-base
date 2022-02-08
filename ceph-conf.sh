#!/bin/bash 
# --
#  Shinya Matsui
# http://dokuwiki.fl8.jp
# 
#############################################################

if [ ! -x /usr/bin/ceph ];then
    sudo apt -y install ceph-common 
fi
sudo -u matsui juju ssh ceph-mon/0 sudo cat /etc/ceph/ceph.conf > /tmp/ceph.conf
sudo -u matsui juju ssh ceph-mon/0 sudo cat /etc/ceph/ceph.client.admin.keyring > /tmp/ceph.client.admin.keyring


sudo cp -rf /tmp/ceph.conf /etc/ceph/ceph.conf
sudo cp -rf /tmp/ceph.client.admin.keyring /etc/ceph/ceph.client.admin.keyring
