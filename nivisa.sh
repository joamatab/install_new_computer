#!/bin/sh

pkgver=17.0.0
_short_ver=${pkgver%.0}
source="http://ftp.ni.com/support/softlib/visa/NI-VISA/${_short_ver}/Linux/NI-VISA-${pkgver}.iso"
wget $source
