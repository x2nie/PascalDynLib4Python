echo off
setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\vcvars32.bat"
"C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\cl.exe" testfoo.cpp foo.lib   
