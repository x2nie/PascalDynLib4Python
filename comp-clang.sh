#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  clang -L. -lfoo -m32 -otestfoo testfoo.c
  clang -L. -lfoo -m64 -otestfoo64 testfoo.c
  lipo -create testfoo testfoo64 -output testfoo
  rm testfoo64
else  #Linux
  clang -L. -lfoo64 -m64 -otestfoo testfoo.c
fi
