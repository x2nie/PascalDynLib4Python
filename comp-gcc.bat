echo off
setlocal
set PATH=C:\Tools\MinGW\bin;%PATH%
C:\Tools\MinGW\bin\gcc -L. -lfoo -otestfoo.exe testfoo.c %1
