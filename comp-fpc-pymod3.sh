#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  ppc386 -dUSE_PYTHON3 -k/Library/Frameworks/Python.framework/Versions/3.5/Python -ofoomod_3.so foomod.pas
  ppcx64 -dUSE_PYTHON3 -k/Library/Frameworks/Python.framework/Versions/3.5/Python -ofoomod64_3.so foomod.pas
  lipo -create foomod_3.so foomod64_3.so -output foomod_3.so
  install_name_tool -id ./foomod_3.so foomod_3.so
  rm foomod64_3.so
else  #Linux
  ppcx64 -dUSE_PYTHON3 -Cg -ofoomod64_3.so foomod.pas
fi
