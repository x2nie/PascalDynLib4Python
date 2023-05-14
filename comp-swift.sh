#!/bin/bash
if [ ${OSTYPE:0:6} = "darwin" ]; then
  swiftc -import-objc-header foo.h -L. -lfoo testfoo.swift
else  #Linux
  swiftc -import-objc-header foo.h -L. -lfoo64 testfoo.swift
fi
