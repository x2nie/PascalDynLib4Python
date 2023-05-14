#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  ppc386 -k-framework -kPython -ofoomod.so foomod.pas
  ppcx64 -k-framework -kPython -ofoomod64.so foomod.pas
  lipo -create foomod.so foomod64.so -output foomod.so
  install_name_tool -id ./foomod.so foomod.so
  rm foomod64.so
else  #Linux
  ppcx64 -Cg -ofoomod64.so foomod.pas
fi
