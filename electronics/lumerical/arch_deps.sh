#!/bin/sh

echo "Installing prerequisites..."
package_helper=`pacman -Qs yay`
packages="libxss xmlsec libpng12 lib32-glibc gstreamer freeglut libtiff"
if [ -n "$package_helper" ]; then
    yay -Sy $packages
else
    package_helper=`pacman -Qs yaourt`
    if [ -n "$package_helper" ]
        then
            yaourt -Sy $packages
    else
        echo "Neither 'yay' nor 'yaourt' is installed."
        exit
    fi
fi


echo "Installing ld-lsb..."
packages="ld-lsb"
if [ -n "$package_helper" ]
    then
        yay -Sy $packages
    else
        package_helper=`pacman -Qs yaourt`
        if [ -n "$package_helper" ]
            then
                yaourt -Sy $packages
        else
            echo "Neither 'yay' nor 'yaourt' is installed."
            exit
        fi
fi


cd /usr/lib
sudo pacman -Syu openssl-1.0
sudo ln -sf libcrypto.so.1.0.0 libcrypto.so.10
