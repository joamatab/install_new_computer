# OpenVPN

## Server initial setup

After launching machine from AWS marketplace t3.small

```
Please specify the network interface and IP address to be
used by the Admin Web UI:
(1) all interfaces: 0.0.0.0
(2) ens5: 172.31.8.222
Please enter the option number from the list above (1-2).
> Press Enter for default [1]: 2
```

This is more secure, as it only allows people inside the VPN to access admin portal

Please specify the port number for the Admin Web UI.

> Press ENTER for default [943]:

Please specify the TCP port number for the OpenVPN Daemon

> Press ENTER for default [443]:

Should client traffic be routed by default through the VPN?

> Press ENTER for default [no]: no

Should client DNS traffic be routed by default through the VPN?

## Export certificates

- [Migtating link](https://openvpn.net/vpn-server-resources/migrating-an-access-server-installation/)

On the VPN machine

```
sudo su
cd /usr/local/openvpn_as/
./bin/sqlite3 ./etc/db/config.db .dump > ./config.db.bak
./bin/sqlite3 ./etc/db/certs.db .dump > ./certs.db.bak
./bin/sqlite3 ./etc/db/userprop.db .dump > ./userprop.db.bak
./bin/sqlite3 ./etc/db/log.db .dump > ./log.db.bak
cp ./etc/as.conf ./as.conf.bak

cd /usr/local/openvpn_as/
zip -r backup.zip bak
```

from my local machine

```
scp vpn2:/usr/local/openvpn_as/backup.zip .
scp backup.zip vpn3:
```

## Import certificates

```
sudo su
cp backup.zip
apt install unzip
cp backup.zip /usr/local/openvpn_as/
service openvpnas stop
unzip backup.zip
cd /usr/local/openvpn_as/
rm ./etc/db/config.db
rm ./etc/db/certs.db
rm ./etc/db/userprop.db
rm ./etc/db/log.db
rm ./etc/as.conf
./bin/sqlite3 <./bak/config.db.bak ./etc/db/config.db
./bin/sqlite3 <./bak/certs.db.bak ./etc/db/certs.db
./bin/sqlite3 <./bak/userprop.db.bak ./etc/db/userprop.db
./bin/sqlite3 <./bak/log.db.bak ./etc/db/log.db
cp ./bak/as.conf.bak ./etc/as.conf
service openvpnas start
```

## LDAP integration


## References

- https://protonvpn.com/support/linux-openvpn/
