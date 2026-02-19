# Lumerical

## Install Lumerical

```
make lumerical centos # works for redhat/fedora/centos
make lumerical ubuntu
make lumerical arch
```


## License server

You can install the license server

`make license`

https://support.lumerical.com/hc/en-us/articles/360024804834-FlexLM-configuration

### Control access

OPTIONS file, allows us to control access to license features
`sudo vi /opt/lumerical/lumerical-flexlm/licenses/LUMERICL/LUMERICL.opt`
https://kb.lumerical.com/en/index.html?install_flexnet_adv_restrict_user_access.html

- using the TIMEOUT / TIMEOUTALL option to specifically timeout and return a license feature or all licenses, when there is no activity between the client and the license manager. Timing out and automatically closing down unused GUIs? So we don’t have to haunt designers who left the GUI open
- RESERVE option allows to allocate license to a user, group of users or hosts/client computers.

We reserve a GUI so we can run a script .lsf file, since the script interpreter is part of the GUI, as described in this video:
https://youtu.be/lmtHD5ErGi4

### Reserve licenses

```
GROUP test ubuntu centos

RESERVE 1 FDTD_Solutions_design GROUP test
RESERVE 1 MODE_Solutions_design GROUP test
```

### TIMEOUT licenses

For the TIMEOUT / TIMEOUTALL options you can use

```
TIMEOUT FDTD_Solutions_design 900
```

Checks FDTD CAD every 900 secs, then it will check-in / return the license

```
TIMEOUTALL 900
```

This second option checks all of the licenses every 900 secs and returns those that do not have active communication with the license manager

```
TIMEOUT FDTD_Solutions_design 900
TIMEOUT MODE_Solutions_design 900
TIMEOUT layout_ide 900
TIMEOUT Lumerical_INTERCONNECT_design  900
TIMEOUTALL 900
```

## Commands

sudo /opt/lumerical/lumerical-flexlm/etc/lumlmadmin restart
sudo /etc/init.d/lumlmadmin restart # do not use this one!

## Cluster

https://kb.lumerical.com/en/installation_and_setup_using-aws-integration.html
