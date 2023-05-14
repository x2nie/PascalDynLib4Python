echo off
setlocal
C:\Tools\LLVM\bin\clang -c -IC:\Tools\MinGW\include testfoo.cpp
set PATH=C:\Tools\MinGW\bin;%PATH%
C:\Tools\MinGW\bin\gcc -L. -lfoo -otestfoo.exe testfoo.o
