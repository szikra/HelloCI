cd ..
mkdir build
cd build

@SetLocal EnableDelayedExpansion
@echo off
echo Removing GCC from path to leave only clang...
set np=%path%
set np=%np:\;=;%
for /f "tokens=*" %%I in ('where gcov') do (
  @set fn=%%I
  set p=!fn:~0,-9%!;
  CALL SET "np=%%np:!p!=%%"
  echo   - !p!
)
set np=%np:;;=;%
set path=%np%
rem path
echo Because cmake/ctest is stupid we need to find llvm-cov for it...
for /f "tokens=*" %%I in ('where llvm-cov') do (
  set llvmcov=%%I
  echo   + Found coverage command: !llvmcov!
  goto found
)
echo   :( Coverage command was NOT found
:found
@echo on

cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS_DEBUG="--coverage -O0" "-DCOVERAGE_COMMAND=%llvmcov%" "-DCOVERAGE_EXTRA_FLAGS=gcov -l"
cmake --build .
ctest -T Test -T Coverage

@Endlocal
