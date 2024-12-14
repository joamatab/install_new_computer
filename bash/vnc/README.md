# Windows

- https://github.com/Ylianst/MeshCentral

# redhat 7.5

```
sudo su
vi /etc/systemd/system/vncserver@.service
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
systemctl daemon-reload
systemctl enable vncserver@:1.service


firewall-cmd --permanent --zone=public --add-port=5903/tcp

```

vncserver -kill :1
vncserver -geometry 2304x1440

- https://www.linuxtechi.com/install-configure-vnc-server-centos-7-rhel-7/
- https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-remote-access-for-the-gnome-desktop-on-centos-7

# RDP

sudo yum -y update
sudo yum groupinstall -y "Server with GUI"
sudo s systemctl set-default graphical.target
sudo systemctl default

sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-

https://devopscube.com/how-to-setup-gui-for-amazon-ec2-rhel-7-instance/
