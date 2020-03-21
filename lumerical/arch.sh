#!/bin/sh

make lumerical

lumericalInstall=./opt/lumerical/2020a
installDir=$HOME/.lumerical

echo "Installing Lumerical..."
mv $lumericalInstall $installDir

sudo -s <<EOF
echo "Adding libraries to the dynamic linker..."
ldconfig ${installDir}/lib
EOF


