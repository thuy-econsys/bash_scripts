#!/bin/bash

## add tcpdump user
# $ adduser tcpdump

## add tcpdump group
# $ addgroup tcpdump

## add your user to tcpdump group
# $ usermod -aG tcpdump $USER

## change owner and group to tcpdump
# $ chown tcpdump:tcpdump /usr/sbin/tcpdump

## set permissios for owner to have all privileges, group to read and execute, and no privileges for others.
# $ chmod 750 /usr/sbin/tcpdump

## add symbolic (-s) link to point to local binary user path
# ln -s /usr/sbin/tcpdump /usr/local/bin/tcpdump

## confirm privileges and symbolic link are set correctly
# $ ls -l /usr/sbin/tcpdump
# -rwxr-x--- 1 tcpdump tcpdump 1044072 Nov  7  2020 /usr/sbin/tcpdump
# $ ls -l /usr/local/bin/tcpdump
# lrwxrwxrwx 1 tcpdump tcpdump 17 Sep 26 17:05 /usr/local/bin/tcpdump -> /usr/sbin/tcpdump

## allow tcpdump to open its raw socket, giving CAP_NET_RAW capabilities
# $ setcap cap_net_raw=eip /usr/sbin/tcpdump

## make sure it's set
# getcap /usr/sbin/tcpdump
# /usr/sbin/tcpdump = cap_net_admin,cap_net_raw+eip

## create directory to store dumps and execute script
# $ mkdir ~/Documents/tcp-dumps
# $ ./tcp-dumph.sh <interface>

state=$(cat /sys/class/net/$1/operstate)

    if [ $state == "up" ]; then
        sudo tcpdump -i $1 -nn -w $HOME/Documents/tcp-dumps/$1-$(date +'%Y%m%d:%H:%M:%S').pcap
    else
        echo "interface $1 state $state at $( date +'%H:%M:%S')"
    fi
