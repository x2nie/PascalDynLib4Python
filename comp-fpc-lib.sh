#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  ppc386 foo.pas
  ppcx64 -olibfoo64.dylib foo.pas
  lipo -create libfoo.dylib libfoo64.dylib -output libfoo.dylib
  install_name_tool -id ./libfoo.dylib libfoo.dylib
  rm libfoo64.dylib
else  #Linux
  ppcx64 -Cg -k-fPIC -olibfoo64.so foo.pas
fi
