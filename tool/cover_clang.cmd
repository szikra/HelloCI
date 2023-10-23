mkdir ..\build
mkdir ..\build\clang
cd ..\build\clang
clang --coverage -g -O0 -DTEST_FAIL_TO_COVER ..\..\source\hello_c.c -o hello_c.exe
hello_c.exe
llvm-cov gcov "hello_c.exe-hello_c."