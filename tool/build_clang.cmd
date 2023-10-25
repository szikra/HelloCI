@echo off
@echo Usage: %~n0 [Release]
@rem default is Debug build, if called with any argument build Release
set config=Debug
if "x%~1" NEQ "x" set config=Release


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
rem @echo on


mkdir ..\build\cclang
cd ..\build\cclang

cmake ../.. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=%config% "-DCOVERAGE_COMMAND=%llvmcov%" "-DCOVERAGE_EXTRA_FLAGS=gcov -l"
cmake --build .
ctest -T Test -T Coverage

@Endlocal
