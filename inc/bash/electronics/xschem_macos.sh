
brew install \
  gtk+3 \
  cairo \
  libffi \
  pango \
  glib \
  gawk \
  libx11 \
  libxrender \
  libxft \
  libxpm \
  libtool \
  automake \
  autoconf \
  pkg-config \
  git

brew install --cask xquartz

[ ! -d xschem ] && git clone git@github.com:StefanSchippers/xschem.git
cd xschem
./configure --prefix=/usr/local
make
sudo make install
