echo off
setlocal
C:\Tools\LLVM\bin\clang -c -IC:\Tools\MinGW\include testfoo.c %1
set PATH=C:\Tools\MinGW\bin;%PATH%
C:\Tools\MinGW\bin\gcc -L. -lfoo -otestfoo.exe testfoo.o
