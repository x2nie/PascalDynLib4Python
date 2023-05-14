# FooLib.py
import sys, platform
if sys.version < "3":  #Python 2.x
  if ((sys.platform == "win32") or (sys.platform == "linux2")) and \
     (platform.architecture()[0] == "64bit"):
    import foomod64 as foomod  #64-bit Python, so use 64-bit module and lib
  else:
    import foomod
else:  #Python 3.x
  if ((sys.platform == "win32") or (sys.platform == "linux")) and \
     (platform.architecture()[0] == "64bit"):
    import foomod64_3 as foomod  #64-bit Python, so use 64-bit module and lib
  else:
    import foomod_3 as foomod


class FooLib(object):
  def __init__(self):
    pass  #Substitute any code here to initialize object

  def __del__(self):
    pass  #Substitute any code here to uninitialize object

  def GetVal(self, InParam):
    return foomod.GetVal(InParam)
