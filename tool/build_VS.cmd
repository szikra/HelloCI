cd ..
mkdir build
cd build
mkdir cmsvc
cd cmsvc

cmake ../..
cmake --build . --config Debug
ctest -C Debug -T Test -T Coverage
rem ctest -C Debug -T Test

CodeCoverage.exe collect /output:"Debug\hello.coverage" Debug\HelloCI_C.exe 
CodeCoverage.exe analyze /output:coverage.xml Debug\hello.coverage

