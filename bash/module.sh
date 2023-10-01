
curl -LJO https://github.com/cea-hpc/modules/releases/download/v5.2.0/modules-5.2.0.tar.gz
tar xfz modules-5.2.0.tar.gz
cd modules-5.2.0/
./configure
make
sudo make install
