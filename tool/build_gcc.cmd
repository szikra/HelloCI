@echo off
@echo Usage: %~n0 [Release]
@rem default is Debug build, if called with any argument build Release
set config=Debug
if "x%~1" NEQ "x" set config=Release

mkdir ..\build\cgcc
cd ..\build\cgcc

cmake ../.. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=%config%
@rem -DCMAKE_BUILD_TYPE=Release
@rem -DCMAKE_C_FLAGS_DEBUG="--coverage -O0"
cmake --build .
ctest -T Test -T Coverage

@rem Profiling
@rem have to run it again for some reason
HelloCI_C.exe
gprof HelloCI_C.exe gmon.out > analysis.txt
