
[ ! Release-7.6.0.tar.gz ] && curl -L https://github.com/Xyce/Xyce/archive/refs/tags/Release-7.6.0.tar.gz | tar xzC  $PWD
cd Xyce-Release-7.6.0
mkdir trilinos-build
cd trilinos-build

cmake \
-D CMAKE_INSTALL_PREFIX=/path/to/Trilinos_install \
-C path/to/Xyce/cmake/trilinos/trilinos-config.cmake \
path/to/Trilinos

cmake --build . -j 2 -t install
cd ..
mkdir xyce-build
cd xyce-build

cmake \
-D CMAKE_INSTALL_PREFIX=/path/to/install \
-D Trilinos_ROOT=/path/to/Trilinos_install \
path/to/Xyce

cmake --build . -j 2 -t install
