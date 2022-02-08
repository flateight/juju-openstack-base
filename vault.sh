#!/bin/bash
# --
# Shinya Matsui
# http://dokuwiki.fl8.jp
# 
#############################################################

which vault
if [ $? != 0 ];then
    sudo sudo snap install vault
fi
WORK=/tmp/work
IP=`juju status vault | grep 8200 | awk '{print $5}'`
export VAULT_ADDR="http://${IP}:8200"

vault operator init -key-shares=5 -key-threshold=3 > $WORK
cat $WORK

KEY1=`grep 'Unseal Key 1:' $WORK | awk '{print $4}'`
KEY2=`grep 'Unseal Key 2:' $WORK | awk '{print $4}'`
KEY3=`grep 'Unseal Key 3:' $WORK | awk '{print $4}'`
ROOT_TOKEN=`grep 'Initial Root Token:' $WORK | awk '{print $4}'`

vault operator unseal $KEY1
vault operator unseal $KEY2
vault operator unseal $KEY3
export VAULT_TOKEN=$ROOT_TOKEN

vault token create -ttl=10m
juju run-action --wait vault/leader authorize-charm token=$VAULT_TOKEN
juju run-action --wait vault/leader generate-root-ca
