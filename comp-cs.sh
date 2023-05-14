#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  mcs /target:exe /platform:x86 /reference:Foo.Interop.dll /out:testfoo.exe testfoo.cs
else  #Linux
  mcs /target:exe /platform:x64 /reference:Foo64.Interop.dll /out:testfoo.exe testfoo.cs
fi
