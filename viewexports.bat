setlocal
set vcpath="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC"
%vcpath%\bin\dumpbin /exports foo.dll
%vcpath%\bin\dumpbin /exports foo64.dll
