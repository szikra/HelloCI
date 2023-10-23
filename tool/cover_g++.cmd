mkdir ..\build
mkdir ..\build\g++
cd ..\build\g++
g++ --coverage -g -O0 -DTEST_FAIL_TO_COVER ..\..\source\hello_c.c -o hello_c.exe
hello_c.exe
gcov hello_c.exe