
git clone https://github.com/RTimothyEdwards/netgen.git
cd netgen
./configure --with-tcl=/usr/local/opt2/tcl-tk/lib \
--with-tk=/usr/local/opt2/tcl-tk/lib \
--x-includes=/opt/X11/include \
--x-libraries=/opt/X11/lib \
CFLAGS=-Wno-error=implicit-function-declaration
make
sudo make install
