setlocal
set vcpath="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC"
%vcpath%\bin\lib /DEF:foo.def /MACHINE:X86 /OUT:foo.lib
%vcpath%\bin\lib /DEF:foo64.def /MACHINE:X64 /OUT:foo64.lib
