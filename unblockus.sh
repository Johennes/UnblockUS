#!/bin/bash

##############################################################################
## unblockus.sh
##
## Copyright 2011 Johannes Marbach. All rights reserved.
## See the LICENSE file for details.

##############################################################################
## Settings

# List of Unblock US domain name servers
DNS=("208.122.23.22" "208.122.23.23" "184.106.242.193")

# Path to resolv.conf.head
RCH=/etc/resolv.conf.head

# Network reconnection command
#   netcfg2: netcfg2 -r INTERFACE
#   NetworkManager: /etc/rc.d/networkmanager restart (Note that NetworkManager
#     needs to be configured to use resolv.conf.head. See for instance
#     http://bit.ly/vlzqNF)
RECONNECT="netcfg -r $( netcfg current)"

##############################################################################
## Script action

CLEARING="Clearing Unblock US DNS entries from $RCH..."
APPENDING="Appending Unblock US DNS entries to $RCH..."
RECONNECTING="Reconnecting network..."

function usage
{
    echo "USAGE: unblockus.sh [up|down]"
}

function clear
{
    if [ -e $RCH ]; then
        # Clear DNS entries from existing resolv.conf.head
        for dns in ${DNS[@]}; do
            sed -i "/^\s*nameserver\s*$dns\s*$/d" $RCH
        done
    fi
}

function append
{
    # Append DNS entries to resolv.conf.head
    for dns in ${DNS[@]}; do
        echo "nameserver" $dns >> $RCH
    done
}

if [ $@ ]; then
    if [ $@ = "up" ]; then
        if [ -e $RCH ]; then
            echo $CLEARING
            clear
        fi
        
        echo $APPENDING
        append
        
        echo $RECONNECTING
        $RECONNECT
    elif [ "$@" = "down" ]; then
        echo $CLEARING
        clear
        
        echo $RECONNECTING
        $RECONNECT
    else
        usage
    fi
else
    usage
fi
