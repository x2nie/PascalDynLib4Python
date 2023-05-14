#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  vbnc /target:library /out:Foo.Interop.dll FooLib.vb
else  #Linux
  vbnc /target:library /define:USE_64_BIT /out:Foo64.Interop.dll FooLib.vb
fi

# Note vbnc currently produces .dll that's not usable by mcs.
