UnblockUS
=========

A DNS toggle utility for UnblockUS

This is a shell script that appends/strips Unblock US domain name server
entries to/from `resolv.conf.head` and resets your internet connection.

### Usage

```shell
unblockus.sh [up|down]
```

The script is configured for use on Arch Linux in Germany. Depending on your
location and system, you may need to change the DNS servers, the path to
`resolv.conf.head` and the network reconnection command in the script's
_Settings_ section.
