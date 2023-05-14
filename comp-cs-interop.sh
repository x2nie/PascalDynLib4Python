#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  mcs /target:library /platform:x86 /out:Foo.Interop.dll FooLib.cs
else  #Linux
  mcs /target:library /platform:x64 /define:USE_64_BIT /out:Foo64.Interop.dll FooLib.cs
fi
