cd ..
mkdir build
cd build
mkdir cmsvc
cd cmsvc

cmake ../..
cmake --build . --config Debug
cmake --build . --config Release
ctest -C Debug -T Test -T Coverage
ctest -C Release -T Test -T Coverage
rem ctest -C Debug -T Test

CodeCoverage.exe collect /output:"Debug\hello.coverage" Debug\HelloCI_C.exe 
CodeCoverage.exe analyze /output:coverage.xml Debug\hello.coverage

