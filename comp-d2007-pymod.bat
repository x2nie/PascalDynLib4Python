"C:\Tools\RAD Studio\5.0\bin\dcc32" foomod.pas /cc %1
erase foomod.pyd
ren foomod.dll foomod.pyd
"C:\Tools\RAD Studio\5.0\bin\dcc32" foomod.pas /dUSE_PYTHON3 /cc %1
erase foomod_3.pyd
ren foomod.dll foomod_3.pyd
