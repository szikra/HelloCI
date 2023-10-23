cd ..
mkdir build
cd build
mkdir cgcc
cd cgcc

cmake ../.. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS_DEBUG="--coverage -O0"
cmake --build .
ctest -T Test -T Coverage
