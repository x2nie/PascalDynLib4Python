# testfoo.py
import sys
if (sys.platform == "cli"):  #IronPython?
  import clr
  clr.AddReference("Foo.Interop")
  import Foo.Interop as FooLib
# Note: If Mono's IronPython does not include standard modules (os, etc.), point
#  to CPython's with IRONPYTHONPATH environment variable or sys.path.append.
else:  #CPython
  import FooLib

try:
  print(FooLib.FooLib().GetVal(4 * 110))
except:
  print(sys.exc_info()[0])  #exception name in form module.classname
  print(sys.exc_info()[1])  #exception error message
