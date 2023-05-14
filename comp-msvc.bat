echo off
setlocal
set vcpath="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC"
call %vcpath%\bin\vcvars32.bat
%vcpath%\bin\cl.exe testfoo.c foo.lib %1  
call %vcpath%\bin\amd64\vcvars64.bat
%vcpath%\bin\amd64\cl.exe /Fetestfoo64.exe testfoo.c foo64.lib %1   
