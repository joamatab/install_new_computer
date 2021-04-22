#!/bin/sh
# adapdted from https://gist.github.com/jimrybarski/eb31eb71afd63b04d356

# if [[ $EUID -ne 0 ]]; then
#    echo "Please run as root."
#    exit 1
# fi

VERSION=2021.1

# Download Pycharm
if [ ! -f /tmp/pycharm.tar.gz ]; then
    wget -O "$HOME"/Downloads/pycharm.tar.gz "https://download.jetbrains.com/python/pycharm-community-$version.tar.gz"
fi

tar -xf "$HOME"/Downloads/pycharm.tar.gz --directory /opt
# tar xvfz "$HOME/Downloads/pycharm-community-$VERSION.tar.gz"
# sudo cp -r "pycharm-community-$VERSION" /opt/pycharm

if [ -f /usr/bin/pycharm ]; then
    rm /usr/bin/pycharm
fi

# Create a symlink. Now you can run pycharm on the command line and
# on the first run, it will create a start menu shortcut and such
# ln -s "/opt/pycharm-community-$version/bin/pycharm.sh" /usr/bin/pycharm
# ln -s "/opt/pycharm/bin/pycharm.sh" /usr/bin/pycharm
ln -sf "$PWD/pycharm-community-$VERSION/bin/pycharm.sh"  /usr/bin/pycharm
