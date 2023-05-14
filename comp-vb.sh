#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  vbnc /target:exe /reference:Foo.Interop.dll testfoo.vb 
else  #Linux
  vbnc /target:exe /reference:Foo64.Interop.dll testfoo.vb 
fi
