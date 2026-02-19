#!/bin/sh

echo "==> Configuring passwordless sudo for wheel group..."

newperms() {
	sed -i "/#LARBS/d" /etc/sudoers
	echo "$* #LARBS" >> /etc/sudoers
}

echo "    Setting wheel group NOPASSWD access..."
newperms "%wheel ALL=(ALL) NOPASSWD: ALL"

echo "    Setting fine-grained sudo permissions (shutdown, reboot, mount, pacman, etc.)..."
newperms "%wheel ALL=(ALL) ALL #LARBS
%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/packer -Syu,/usr/bin/packer -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/rc-service NetworkManager restart,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/pacman -Syyuw --noconfirm"

echo "    Adding $USER to NOPASSWD sudoers..."
echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo "==> Done! Passwordless sudo configured."
